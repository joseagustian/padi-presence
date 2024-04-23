
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/utils/app_logger.dart';
import 'package:padi/modules/dashboard/infra/sources/monthly_activity_services.dart';

import 'domains/entities/monthly_activity_entity.dart';
import 'domains/usecases/monthly_activity_usecase.dart';

final monthlyActivityServiceProvider = Provider<MonthlyActivityServices>((ref) {
  return MonthlyActivityServices();
});

final monthlyActivityUseCaseProvider = Provider<MonthlyActivityUseCase>((ref) {
  final monthlyActivityServices = ref.watch(monthlyActivityServiceProvider);
  return MonthlyActivityUseCase(monthlyActivityServices);
});

final getMonthlyActivityProvider = Provider.autoDispose<MonthlyActivityProvider>((ref) {
  final monthlyActivityUseCase = ref.watch(monthlyActivityUseCaseProvider);
  return MonthlyActivityProvider(monthlyActivityUseCase);
});

final monthlyActivityProvider = FutureProvider.autoDispose<MonthlyActivity>((ref) async {
  final monthlyActivityProvider = ref.watch(getMonthlyActivityProvider);
  return monthlyActivityProvider.monthlyActivity();
});

class MonthlyActivityProvider {
  final MonthlyActivityUseCase monthlyActivityUseCase;

  MonthlyActivityProvider(this.monthlyActivityUseCase);

  AppLogger logger = AppLogger();

  bool isLoading = false;
  String? error;

  MonthlyActivity? response;

  Future<MonthlyActivity> monthlyActivity() async {
    isLoading = true;
    logger.recordLog(LoggerMessage.fetchWorkingTimeSummary, LogType.info);
    try {
      response = await monthlyActivityUseCase.getMonthlyActivity();
      isLoading = false;
      return response!;
    } on Exception catch (e) {
      logger.recordLog(e.toString().replaceAll('Exception:', ''), LogType.error);
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