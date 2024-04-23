
import 'package:padi/modules/shared/domains/security_question/entities/security_question_entity.dart';
import 'package:padi/modules/shared/infra/sources/security_question_service.dart';

class SecurityQuestionUseCase {
  final SecurityQuestionServices securityQuestionServices;

  SecurityQuestionUseCase(this.securityQuestionServices);

  Future<SecurityQuestions> getSecurityQuestions() async {
    final securityQuestionData = await securityQuestionServices.getSecurityQuestions();

    final securityQuestion = SecurityQuestions(
      status: securityQuestionData.status,
      data: securityQuestionData.data.map((e) => QuestionData(
        id: e.id,
        question: e.question,
      )).toList(),
      message: securityQuestionData.message,
    );

    return securityQuestion;
  }
}