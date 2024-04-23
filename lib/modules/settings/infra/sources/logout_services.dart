import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/data/database/providers/padi_user_table_provider.dart';
import 'package:padi/modules/settings/infra/models/logout_model.dart';

class LogoutServices {
  PadiUserTableDataProvider padiUserTableProvider = PadiUserTableDataProvider();

  Future<LogoutModel> logout() async {

    ApiRequest apiRequest = ApiRequest();

    final token = await padiUserTableProvider.getUserToken();

    final response = await apiRequest.post(
        '/logout',
        null,
        token
    );

    if (response.statusCode == 200) {
      return LogoutModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception;
    }

  }

}