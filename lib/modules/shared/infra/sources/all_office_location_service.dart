import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/modules/shared/infra/models/all_office_location_model.dart';

class AllOfficeLocationService {

  Future<AllOfficeLocationModel> getAllOfficeLocation() async {

    ApiRequest apiRequest = ApiRequest();

    final response = await apiRequest.get(
      '/location/find-all',
      null
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responses = json.decode(response.body);
      return AllOfficeLocationModel.fromJson(responses);
    } else {
      throw Exception('Failed to load all office location');
    }

  }

}