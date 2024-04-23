
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/shared/domains/security_question/entities/security_question_entity.dart';
import 'package:padi/modules/shared/domains/security_question/usecases/security_question_usecase.dart';
import 'package:padi/modules/shared/infra/sources/security_question_service.dart';

final securityQuestionServicesProvider = Provider<SecurityQuestionServices>((ref) {
  return SecurityQuestionServices();
});

final securityQuestionUseCaseProvider = Provider<SecurityQuestionUseCase>((ref) {
  final securityQuestionServices = ref.watch(securityQuestionServicesProvider);
  return SecurityQuestionUseCase(securityQuestionServices);
});

final getSecurityQuestionProvider = Provider<SecurityQuestionProvider>((ref) {
  final securityQuestionUseCase = ref.watch(securityQuestionUseCaseProvider);
  return SecurityQuestionProvider(securityQuestionUseCase);
});

final securityQuestionProvider = FutureProvider.autoDispose<SecurityQuestions>((ref) async {
  final securityQuestionProvider = ref.watch(getSecurityQuestionProvider);
  return securityQuestionProvider.getSecurityQuestions();
});

class SecurityQuestionProvider {
  final SecurityQuestionUseCase securityQuestionUseCase;

  SecurityQuestionProvider(this.securityQuestionUseCase);

  bool isLoading = false;
  String? error;

  SecurityQuestions? response;

  Future<SecurityQuestions> getSecurityQuestions() async {

    isLoading = true;

    try {
      response = await securityQuestionUseCase.getSecurityQuestions();
      isLoading = false;
      return response!;
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