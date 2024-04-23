
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/utils/app_logger.dart';
import 'package:padi/modules/attendance/record/domains/entities/attendance_correction_entity.dart';
import 'package:padi/modules/attendance/record/infra/models/attendance_correction_model.dart';

import 'domains/usecases/attendance_correction_usecase.dart';
import 'infra/sources/attendance_correction_services.dart';

final attendanceCorrectionServicesProvider = Provider<AttendanceCorrectionServices>((ref) {
  return AttendanceCorrectionServices();
});

final attendanceCorrectionUseCaseProvider = Provider<AttendanceCorrectionUseCase>((ref) {
  final attendanceCorrectionServices = ref.watch(attendanceCorrectionServicesProvider);
  return AttendanceCorrectionUseCase(attendanceCorrectionServices);
});

final attendanceCorrectionProvider = Provider<AttendanceCorrectionProvider>((ref) {
  final attendanceCorrectionUseCase = ref.watch(attendanceCorrectionUseCaseProvider);
  return AttendanceCorrectionProvider(attendanceCorrectionUseCase);
});

class AttendanceCorrectionProvider {
  final AttendanceCorrectionUseCase attendanceCorrectionUseCase;

  AttendanceCorrectionProvider(this.attendanceCorrectionUseCase);

  AppLogger logger = AppLogger();

  bool isLoading = false;
  String? error;

  Future<AttendanceCorrection> correction(AttendanceCorrectionBody body, String? attendanceId) async {
    isLoading = true;
    logger.recordLog(LoggerMessage.sendAttendanceCorrectionRequest, LogType.info);
    try {
      final attendanceCorrection = await attendanceCorrectionUseCase.attendanceCorrection(body, attendanceId);
      isLoading = false;
      return attendanceCorrection;
    } catch (e) {
      logger.recordLog(LoggerMessage.failedToSendAttendanceCorrectionRequest, LogType.error);
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