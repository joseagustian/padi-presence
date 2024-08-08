
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/utils/date_time_formatter.dart';
import 'package:padi/core/utils/shared_preferences.dart';
import 'package:padi/modules/attendance/record/domains/entities/attendance_by_id_entity.dart';
import 'package:padi/modules/attendance/record/domains/usecases/attendance_by_id_usecase.dart';
import 'package:padi/modules/dashboard/today_activity_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/app_logger.dart';
import 'infra/sources/attendance_by_id_services.dart';

final attendanceDataByIDServiceProvider = Provider<AttendanceDataByIDServices>((ref) {
  return AttendanceDataByIDServices();
});

final attendanceDataByIDUseCaseProvider = Provider<AttendanceDataByIDUseCase>((ref) {
  final attendanceDataByIDServices = ref.watch(attendanceDataByIDServiceProvider);
  return AttendanceDataByIDUseCase(attendanceDataByIDServices);
});

final getAttendanceDataByIDProvider = Provider.family<AttendanceDataByIDProvider, String>((ref,attendanceId) {
  final attendanceDataByIDUseCase = ref.watch(attendanceDataByIDUseCaseProvider);
  return AttendanceDataByIDProvider(attendanceDataByIDUseCase);
});

final attendanceDataByIDProvider = FutureProvider.autoDispose.family<AttendanceDataById, String>((ref, attendanceId) async {
  final attendanceDataByIDProvider = ref.watch(getAttendanceDataByIDProvider(attendanceId));
  return attendanceDataByIDProvider.attendanceHistoryDetail(attendanceId);
});

class AttendanceDataByIDProvider {
  final AttendanceDataByIDUseCase attendanceDataByIDUseCase;

  AttendanceDataByIDProvider(this.attendanceDataByIDUseCase);

  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  bool isLoading = false;
  String? error;
  bool isGetLatestAttendanceSuccess = false;
  String? lastAttendanceTime;
  String? checkInTime;
  String? checkOutTime;
  String? workHour;

  AttendanceDataById? response;

  AppLogger logger = AppLogger();

  Future<AttendanceDataById> attendanceHistoryDetail(String attendanceId) async {
    isLoading = true;
    logger.recordLog(LoggerMessage.fetchAttendanceHistoryDetail, LogType.info);
    try {
      response = await attendanceDataByIDUseCase.getAttendanceDetailByID(attendanceId);
      isLoading = false;
      return response!;
    } on Exception catch (e) {
      logger.recordLog(LoggerMessage.failedToFetchAttendanceHistoryDetail, LogType.error);
      if (e.toString().contains('SocketException')) {
        error = Strings.noInternetConnection;
      } else if (e.toString().contains('TimeoutException')) {
        error = Strings.failToConnectToServer;
      } else {
        error = e.toString();
      }
      throw Exception(error);
    }
  }

  Future setLastAttendanceButton() async {
    final shouldSetAttendanceButtonState = await prefs.getPrefs(PrefsKey.shouldSetAttendanceButtonState);
    final lastAttendanceId = await prefs.getPrefs(PrefsKey.recentAttendanceId);
    if (shouldSetAttendanceButtonState) {

      if (lastAttendanceId == null) {
        prefs.savePrefs(PrefsKey.isCheckedIn, false);
        prefs.savePrefs(PrefsKey.isCheckedOut, false);
        prefs.savePrefs(PrefsKey.isTodayFinished, false);
      }

      try {
        response = await attendanceDataByIDUseCase.getAttendanceDetailByID(lastAttendanceId);

        if (response!.message == Strings.internalServerError || (response?.data.isNotEmpty == true && response!.data[0].checkIn!.checkInTime == "1970-01-01 07:00:00")) {
          prefs.savePrefs(PrefsKey.isCheckedIn, false);
          prefs.savePrefs(PrefsKey.isCheckedOut, false);
          prefs.savePrefs(PrefsKey.isTodayFinished, false);
        } else if (response?.data.isNotEmpty == true && response!.data[0].checkIn!.checkInTime != null) {
          prefs.savePrefs(PrefsKey.isCheckedIn, true);
          prefs.savePrefs(PrefsKey.isCheckedOut, false);
          prefs.savePrefs(PrefsKey.isTodayFinished, false);
          checkInTime = getTimeFromAttendanceTime(response!.data[0].checkIn!.checkInTime);
          prefs.savePrefs(PrefsKey.attendanceCheckInTime, checkInTime);
          workHour = response!.data[0].workingHours!;
          prefs.savePrefs(PrefsKey.attendanceWorkingHours, workHour);
          isGetLatestAttendanceSuccess = true;
          await prefs.savePrefs(PrefsKey.shouldSetAttendanceButtonState, false);
        }

        if (response?.data.isNotEmpty == true && response!.data[0].checkOut!.checkOutTime != null) {
          prefs.savePrefs(PrefsKey.isCheckedIn, false);
          prefs.savePrefs(PrefsKey.isCheckedOut, true);
          prefs.savePrefs(PrefsKey.isTodayFinished, true);
          lastAttendanceTime = formatDateToIso8601WithMilliseconds(response!.data[0].checkOut!.checkOutTime!);
          prefs.savePrefs(PrefsKey.lastAttendanceTime, lastAttendanceTime);

          checkInTime = getTimeFromAttendanceTime(response!.data[0].checkIn!.checkInTime);
          prefs.savePrefs(PrefsKey.attendanceCheckInTime, checkInTime);
          workHour = response!.data[0].workingHours!;
          prefs.savePrefs(PrefsKey.attendanceWorkingHours, workHour);
          checkOutTime = getTimeFromAttendanceTime(response!.data[0].checkOut!.checkOutTime);
          prefs.savePrefs(PrefsKey.attendanceCheckOutTime, checkOutTime);

          isGetLatestAttendanceSuccess = true;
          await prefs.savePrefs(PrefsKey.shouldSetAttendanceButtonState, false);
        }

      } on Exception catch (e) {
        error = e.toString();
        throw Exception(error);
      }
    }
  }

}