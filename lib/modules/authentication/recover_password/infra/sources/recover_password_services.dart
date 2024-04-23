import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/authentication/recover_password/infra/models/recover_password_model.dart';

class RecoverPasswordServices {
  Future<RecoverPasswordModel> recoverPassword(RecoverPasswordBodyRequest body) async {

    ApiRequest apiRequest = ApiRequest();

    final responses = await apiRequest.post(
      '/forgot-password',
      json.encode(body.toJson()),
      null
    );

    if (responses.statusCode == 200) {
      return RecoverPasswordModel.fromJson(jsonDecode(responses.body));
    } else if (responses.statusCode == 404 || responses.statusCode == 400) {
      if (responses.body.contains('Email')) {
        throw Exception(Strings.invalidEmail);
      } else {
        throw Exception(Strings.failToRecoverPassword);
      }
    } else {
      throw Exception(Strings.failToValidateUser);
    }
  }
}