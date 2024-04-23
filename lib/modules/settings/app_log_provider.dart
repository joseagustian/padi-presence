
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'domains/entities/app_log_entity.dart';
import 'domains/usecases/app_log_usecases.dart';
import 'infra/sources/app_log_services.dart';

final appLogServicesProvider = Provider<AppLogServices>((ref) {
  return AppLogServices();
});

final appLogUseCaseProvider = Provider<AppLogUseCase>((ref) {
  final appLogServices = ref.watch(appLogServicesProvider);
  return AppLogUseCase(appLogServices);
});

final getAppLogProvider = Provider<AppLogProvider>((ref) {
  final appLogUseCase = ref.watch(appLogUseCaseProvider);
  return AppLogProvider(appLogUseCase);
});

final appLogProvider = FutureProvider.autoDispose<ApplicationLogs>((ref) async {
  final appLogProvider = ref.watch(getAppLogProvider);
  return appLogProvider.getAppLog();
});

class AppLogProvider {

  final AppLogUseCase appLogUseCase;

  AppLogProvider(this.appLogUseCase);

  bool isLoading = false;
  String? error;

  Future<ApplicationLogs> getAppLog() async {
    isLoading = true;

    try {
      final response = await appLogUseCase.getLogs();
      isLoading = false;
      return response;
    } on Exception catch (e) {
      error = e.toString();
      rethrow;
    }
  }

}