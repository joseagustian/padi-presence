
import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/data/database/providers/padi_user_table_provider.dart';
import 'package:padi/modules/settings/infra/models/update_profile_model.dart';

class UpdateProfileServices {

  PadiUserTableDataProvider padiUserTableProvider = PadiUserTableDataProvider();

  Future<UpdateProfileModel> updateProfile(UpdateProfileBodyRequest body) async {

      ApiRequest apiRequest = ApiRequest();

      final token = await padiUserTableProvider.getUserToken();

      final response = await apiRequest.post(
          '/edit-profile',
          json.encode(body.toJson()),
          token
      );

      if (response.statusCode == 200) {
        return UpdateProfileModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception;
      }
  }

}