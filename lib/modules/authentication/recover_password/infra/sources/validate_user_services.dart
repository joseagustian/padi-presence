import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/authentication/recover_password/infra/models/validate_user_model.dart';

class ValidateUserServices {
  Future<ValidateUserModel> validateUser(ValidateUserBodyRequest body) async {

    ApiRequest apiRequest = ApiRequest();

    final responses = await apiRequest.post(
      '/check-account',
      json.encode(body.toJson()),
      null
    );

    if (responses.statusCode == 200) {
      return ValidateUserModel.fromJson(jsonDecode(responses.body));
    } else if (responses.statusCode == 400) {
      if (responses.body.contains('Email')) {
        throw Exception(Strings.invalidEmail);
      } else if (responses.body.contains('Pertanyaan') || responses.body.contains('Jawaban')) {
        throw Exception(Strings.questionOrAnswerInvalid);
      } else {
        throw Exception(Strings.failToValidateUser);
      }
    } else {
    throw Exception(Strings.failToValidateUser);
    }
  }
}