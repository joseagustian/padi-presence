import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';

import 'domains/entities/register_entity.dart';
import 'domains/usecases/register_usecase.dart';
import 'infra/models/register_model.dart';
import 'infra/sources/register_services.dart';

final registerServicesProvider = Provider<RegisterServices>((ref) {
  return RegisterServices();
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final registerServices = ref.watch(registerServicesProvider);
  return RegisterUseCase(registerServices);
});

final registerProvider = Provider<RegisterProvider>((ref) {
  final registerUseCase = ref.watch(registerUseCaseProvider);
  return RegisterProvider(registerUseCase);
});

class RegisterProvider {
  final RegisterUseCase registerUseCase;

  RegisterProvider(this.registerUseCase);

  bool isLoading = false;
  String? error;

  Future<Register> register(RegisterBodyRequest body) async {
    isLoading = true;

    try {
      final response = await registerUseCase.register(body);
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