import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';

import 'domains/entities/padi_scheduler_entity.dart';
import 'domains/usecases/padi_scheduler_usecase.dart';
import 'infra/sources/padi_scheduler_services.dart';

final padiSchedulerServicesProvider = Provider<PadiSchedulerServices>((ref) {
  return PadiSchedulerServices();
});

final padiSchedulerUseCaseProvider = Provider<PadiSchedulerUseCase>((ref) {
  final padiSchedulerServices = ref.watch(padiSchedulerServicesProvider);
  return PadiSchedulerUseCase(padiSchedulerServices);
});

final padiSchedulerProvider = Provider<PadiSchedulerProvider>((ref) {
  final padiSchedulerUseCase = ref.watch(padiSchedulerUseCaseProvider);
  return PadiSchedulerProvider(padiSchedulerUseCase);
});

class PadiSchedulerProvider {
  final PadiSchedulerUseCase padiSchedulerUseCase;

  PadiSchedulerProvider(this.padiSchedulerUseCase);

  bool isLoading = false;
  String? error;

  Future<PadiScheduler> runScheduler() async {
    isLoading = true;
    try {
      final result = await padiSchedulerUseCase.runScheduler();
      isLoading = false;
      return result;
    } catch (e) {
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