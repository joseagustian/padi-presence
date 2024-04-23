import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';

import 'domains/entities/recover_password_entity.dart';
import 'domains/usecases/recover_password_usecase.dart';
import 'infra/models/recover_password_model.dart';
import 'infra/sources/recover_password_services.dart';

final recoverPasswordServicesProvider = Provider<RecoverPasswordServices>((ref) {
  return RecoverPasswordServices();
});

final recoverPasswordUseCaseProvider = Provider<RecoverPasswordUseCase>((ref) {
  final recoverPasswordServices = ref.watch(recoverPasswordServicesProvider);
  return RecoverPasswordUseCase(recoverPasswordServices);
});

final recoverPasswordProvider = Provider<RecoverPasswordProvider>((ref) {
  final recoverPasswordUseCase = ref.watch(recoverPasswordUseCaseProvider);
  return RecoverPasswordProvider(recoverPasswordUseCase);
});

class RecoverPasswordProvider {
  final RecoverPasswordUseCase recoverPasswordUseCase;

  RecoverPasswordProvider(this.recoverPasswordUseCase);

  bool isLoading = false;
  String? error;

  Future<RecoverPassword> recoverPassword(RecoverPasswordBodyRequest body) async {
    isLoading = true;

    try {
      final response = await recoverPasswordUseCase.recoverPassword(body);
      isLoading = false;
      return response;
    } on Exception catch (e) {
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