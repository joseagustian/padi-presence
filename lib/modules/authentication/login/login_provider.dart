import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/utils/app_logger.dart';
import 'package:padi/core/utils/shared_preferences.dart';
import 'domains/entities/login_entity.dart';
import 'domains/usecases/login_usecase.dart';
import 'infra/models/login_model.dart';
import 'infra/sources/login_services.dart';

final loginServicesProvider = Provider<LoginServices>((ref) {
  return LoginServices();
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final loginServices = ref.watch(loginServicesProvider);
  return LoginUseCase(loginServices);
});

final loginProvider = Provider<LoginProvider>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  return LoginProvider(loginUseCase);
});

class LoginProvider {
  final LoginUseCase loginUseCase;

  LoginProvider(this.loginUseCase);

  AppLogger logger = AppLogger();
  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  bool isLoading = false;
  String? error;

  Future<Login> login(LoginBodyRequest body) async {
    isLoading = true;
    try {
      final response = await loginUseCase.login(body);
      isLoading = false;
      logger.recordLog(LoggerMessage.lastLogin, LogType.info);
      prefs.savePrefs(PrefsKey.isLoggedIn, true);
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
