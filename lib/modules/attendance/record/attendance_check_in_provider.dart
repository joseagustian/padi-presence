
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/utils/app_logger.dart';
import 'package:padi/core/utils/shared_preferences.dart';
import 'package:padi/modules/attendance/record/domains/entities/attendance_check_in_entity.dart';
import 'package:padi/modules/attendance/record/domains/usecases/attendance_check_in_usecase.dart';
import 'package:padi/modules/attendance/record/infra/models/attendance_check_in_model.dart';
import 'package:padi/modules/attendance/record/infra/sources/attendance_check_in_services.dart';

final attendanceCheckInServicesProvider = Provider<AttendanceCheckInServices>((ref) {
  return AttendanceCheckInServices();
});

final attendanceCheckInUseCaseProvider = Provider<AttendanceCheckInUseCase>((ref) {
  final attendanceCheckInServices = ref.watch(attendanceCheckInServicesProvider);
  return AttendanceCheckInUseCase(attendanceCheckInServices);
});

final attendanceCheckInProvider = Provider<AttendanceCheckInProvider>((ref) {
  final attendanceCheckInUseCase = ref.watch(attendanceCheckInUseCaseProvider);
  return AttendanceCheckInProvider(attendanceCheckInUseCase);
});

class AttendanceCheckInProvider {
  final AttendanceCheckInUseCase attendanceCheckInUseCase;

  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  AttendanceCheckInProvider(this.attendanceCheckInUseCase);
  AppLogger logger = AppLogger();

  bool isLoading = false;
  String? error;

  Future<AttendanceCheckIn> checkIn(CheckInBodyRequest body) async {
    isLoading = true;
    logger.recordLog(LoggerMessage.sendCheckInRequest, LogType.info);
    try {
      final attendanceCheckIn = await attendanceCheckInUseCase.checkIn(body);
      isLoading = false;
      return attendanceCheckIn;
    } catch (e) {
      logger.recordLog(LoggerMessage.failedToSendCheckInRequest, LogType.error);
      isLoading = false;
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

}

