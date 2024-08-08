import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/data/database/providers/padi_user_table_provider.dart';
import 'package:padi/modules/submission/infra/models/create_submission_model.dart';

class CreateSubmissionServices {

  PadiUserTableDataProvider padiUserTableProvider = PadiUserTableDataProvider();

  Future<CreateSubmissionModel> createSubmission(CreateSubmissionBodyRequest body) async {

      ApiRequest apiRequest = ApiRequest();

      final token = await padiUserTableProvider.getUserToken();

      final response = await apiRequest.post(
          '/permission',
          json.encode(body.toJson()),
          token
      );

      if (response.statusCode == 200) {
        return CreateSubmissionModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 400) {
        throw Exception('Unauthorized');
      } else {
        throw Exception('Failed to create submission');
      }
  }

}