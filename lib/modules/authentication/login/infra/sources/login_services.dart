import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/authentication/login/infra/models/login_model.dart';
class LoginServices {
  Future<LoginModel> login(LoginBodyRequest body) async {


    ApiRequest apiRequest = ApiRequest();


    final response = await apiRequest.post(
        '/login',
        json.encode(body.toJson()),
        null
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responses = json.decode(response.body);
      return LoginModel.fromJson(responses);
    } else if (response.statusCode == 400) {
      if (response.body.contains('Akun anda login di device lain')) {
        throw Exception(Strings.accountLoggedInAnotherDevice);
      } else if (response.body.contains('Email')) {
        throw Exception(Strings.invalidEmail);
      } else if (response.body.contains('Password')) {
        throw Exception(Strings.invalidPassword);
      } else {
        throw Exception(Strings.invalidEmailOrPassword);
      }
    } else {
      throw Exception;
    }

  }
}