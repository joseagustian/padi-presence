
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/utils/app_logger.dart';

import 'domains/entities/attendance_history_detail_entity.dart';
import 'domains/usecases/attendance_history_detail_usecase.dart';
import 'infra/sources/attendance_history_detail_services.dart';

final attendanceHistoryDetailServicesProvider = Provider<AttendanceHistoryDetailServices>((ref) {
  return AttendanceHistoryDetailServices();
});

final attendanceHistoryDetailUseCaseProvider = Provider<AttendanceHistoryDetailUseCase>((ref) {
  final attendanceHistoryDetailServices = ref.watch(attendanceHistoryDetailServicesProvider);
  return AttendanceHistoryDetailUseCase(attendanceHistoryDetailServices);
});

final getAttendanceHistoryDetailProvider = Provider.family<AttendanceHistoryDetailProvider, String>((ref,attendanceId) {
  final attendanceHistoryDetailUseCase = ref.watch(attendanceHistoryDetailUseCaseProvider);
  return AttendanceHistoryDetailProvider(attendanceHistoryDetailUseCase);
});

final attendanceHistoryDetailProvider = FutureProvider.autoDispose.family<AttendanceHistoryDetail, String>((ref, attendanceId) async {
  final attendanceHistoryDetailProvider = ref.watch(getAttendanceHistoryDetailProvider(attendanceId));
  return attendanceHistoryDetailProvider.attendanceHistoryDetail(attendanceId);
});

class AttendanceHistoryDetailProvider {
  final AttendanceHistoryDetailUseCase attendanceHistoryDetailUseCase;

  AttendanceHistoryDetailProvider(this.attendanceHistoryDetailUseCase);

  bool isLoading = false;
  String? error;

  AttendanceHistoryDetail? response;

  AppLogger logger = AppLogger();

  Future<AttendanceHistoryDetail> attendanceHistoryDetail(String attendanceId) async {
    isLoading = true;
    logger.recordLog(LoggerMessage.fetchAttendanceHistoryDetail, LogType.info);
    try {
      response = await attendanceHistoryDetailUseCase.getAttendanceHistoryDetail(attendanceId);
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
}