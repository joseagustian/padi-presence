import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/modules/settings/domains/entities/logout_entity.dart';

import 'domains/usecases/logout_usecase.dart';
import 'infra/sources/logout_services.dart';

final logoutServicesProvider = Provider<LogoutServices>((ref) {
  return LogoutServices();
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final logoutServices = ref.watch(logoutServicesProvider);
  return LogoutUseCase(logoutServices);
});

final logoutProvider = Provider<LogoutProvider>((ref) {
  final logoutUseCase = ref.watch(logoutUseCaseProvider);
  return LogoutProvider(logoutUseCase);
});

class LogoutProvider {
  final LogoutUseCase logoutUseCase;

  LogoutProvider(this.logoutUseCase);

  bool isLoading = false;
  String? error;

  Future<Logout> logout() async {
    isLoading = true;

    try {
      final response = await logoutUseCase.logout();
      isLoading = false;
      return response;
    } on Exception catch (e) {
      error = e.toString();
      rethrow;
    }
  }
}