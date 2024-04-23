import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/utils/app_logger.dart';
import 'package:padi/modules/attendance/record/domains/entities/attendance_history_entity.dart';
import 'package:padi/modules/attendance/record/domains/usecases/attendance_history_usecase.dart';
import 'package:padi/modules/attendance/record/infra/sources/attendance_history_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final attendancesHistoryServicesProvider = Provider<AttendancesHistoryServices>((ref) {
  return AttendancesHistoryServices();
});

final attendancesHistoryUseCaseProvider = Provider<AttendancesHistoryUseCase>((ref) {
  final attendancesHistoryServices = ref.watch(attendancesHistoryServicesProvider);
  return AttendancesHistoryUseCase(attendancesHistoryServices);
});

final getAttendancesHistoryProvider = Provider<AttendancesHistoryProvider>((ref) {
  final attendancesHistoryUseCase = ref.watch(attendancesHistoryUseCaseProvider);
  return AttendancesHistoryProvider(attendancesHistoryUseCase);
});

final attendancesHistoryProvider = FutureProvider<AttendancesHistory>((ref) async {
  final attendancesHistoryProvider = ref.watch(getAttendancesHistoryProvider);
  return attendancesHistoryProvider.attendancesHistory();
});

class AttendancesHistoryProvider {
  final AttendancesHistoryUseCase attendancesHistoryUseCase;

  AttendancesHistoryProvider(this.attendancesHistoryUseCase);

  bool isLoading = false;
  String? error;

  AttendancesHistory? response;
  AppLogger logger = AppLogger();
  Future<AttendancesHistory> attendancesHistory() async {
    isLoading = true;
    logger.recordLog(LoggerMessage.fetchAttendanceHistoryList, LogType.info);
    try {
      response = await attendancesHistoryUseCase.getAttendancesHistory();
      isLoading = false;
      return response!;
    } on Exception catch (e) {
      isLoading = false;
      logger.recordLog(LoggerMessage.failedToFetchAttendanceHistoryList, LogType.error);
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