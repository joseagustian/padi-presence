
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/utils/app_logger.dart';
import 'domains/entities/attendance_check_out_entity.dart';
import 'domains/usecases/attendance_check_out_usecase.dart';
import 'infra/models/attendance_check_out_model.dart';
import 'infra/sources/attendance_check_out_services.dart';

final attendanceCheckOutServicesProvider = Provider<AttendanceCheckOutServices>((ref) {
  return AttendanceCheckOutServices();
});

final attendanceCheckOutUseCaseProvider = Provider<AttendanceCheckOutUseCase>((ref) {
  final attendanceCheckOutServices = ref.watch(attendanceCheckOutServicesProvider);
  return AttendanceCheckOutUseCase(attendanceCheckOutServices);
});

final attendanceCheckOutProvider = Provider<AttendanceCheckOutProvider>((ref) {
  final attendanceCheckOutUseCase = ref.watch(attendanceCheckOutUseCaseProvider);
  return AttendanceCheckOutProvider(attendanceCheckOutUseCase);
});

class AttendanceCheckOutProvider {
  final AttendanceCheckOutUseCase attendanceCheckOutUseCase;

  AttendanceCheckOutProvider(this.attendanceCheckOutUseCase);
  AppLogger logger = AppLogger();
  bool isLoading = false;
  String? error;

  Future<AttendanceCheckOut> checkOut(CheckOutBodyRequest body, String? attendanceId) async {
    isLoading = true;
    logger.recordLog(LoggerMessage.sendCheckOutRequest, LogType.info);
    try {
      final attendanceCheckOut = await attendanceCheckOutUseCase.checkOut(body, attendanceId);
      isLoading = false;
      return attendanceCheckOut;
    } catch (e) {
      logger.recordLog(LoggerMessage.failedToSendCheckOutRequest, LogType.error);
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