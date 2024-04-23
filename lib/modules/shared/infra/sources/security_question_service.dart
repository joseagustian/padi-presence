
import 'dart:convert';
import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/constants/strings.dart';

import 'package:padi/modules/shared/infra/models/security_question_model.dart';

class SecurityQuestionServices {
  Future<SecurityQuestionsModel> getSecurityQuestions() async {

    ApiRequest apiRequest = ApiRequest();

    final response = await apiRequest.get(
      '/question',
      null
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responses = json.decode(response.body);
      return SecurityQuestionsModel.fromJson(responses);
    } else {
      throw Exception(Strings.failToLoadSecurityQuestion);
    }
  }
}