import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/shared/infra/models/job_division_model.dart';

class JobDivisionServices {
  Future<JobDivisionsModel> getJobDivisions() async {

    ApiRequest apiRequest = ApiRequest();

    final response = await apiRequest.get(
      '/division',
      null
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responses = json.decode(response.body);
      return JobDivisionsModel.fromJson(responses);
    } else {
      throw Exception(Strings.failToLoadJobDivision);
    }
  }
}