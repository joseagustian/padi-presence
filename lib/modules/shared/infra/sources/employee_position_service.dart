import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/shared/infra/models/employee_position_model.dart';

class EmployeePositionServices {
  Future<EmployeePositionsModel> getEmployeePositions(String divisionId) async {

    ApiRequest apiRequest = ApiRequest();

    final response = await apiRequest.get(
      '/position/$divisionId',
      null
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responses = json.decode(response.body);
      return EmployeePositionsModel.fromJson(responses);
    } else {
      throw Exception(Strings.failToLoadEmployeePosition);
    }
  }
}