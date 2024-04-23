
import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/authentication/register/infra/models/register_model.dart';

class RegisterServices {
  Future<RegisterModel> register(RegisterBodyRequest body) async {

    ApiRequest apiRequest = ApiRequest();

    final response = await apiRequest.post(
      '/register',
      json.encode(body.toJson()),
      null
    );

    if (response.statusCode == 200) {
      return RegisterModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400){
      if (response.body.contains('Email')) {
        throw Exception(Strings.emailAlreadyExist);
      }
      throw Exception(Strings.registrationFailed);
    } else {
      throw Exception(Strings.registrationFailed);
    }
  }
}