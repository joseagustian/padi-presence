
import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/data/database/providers/padi_user_table_provider.dart';
import 'package:padi/modules/attendance/record/infra/models/attendance_check_in_model.dart';

class AttendanceCheckInServices {
  PadiUserTableDataProvider padiUserTableProvider = PadiUserTableDataProvider();
  Future<AttendanceCheckInModel> checkIn(CheckInBodyRequest body) async {

    ApiRequest apiRequest = ApiRequest();

    final token = await padiUserTableProvider.getUserToken();

    final response = await apiRequest.post(
      '/checkin',
        json.encode(body.toJson()),
      token
    );

    if (response.statusCode == 200) {
      return AttendanceCheckInModel.fromJson(json.decode(response.body));
    } else {
      throw Exception;
    }
  }

}