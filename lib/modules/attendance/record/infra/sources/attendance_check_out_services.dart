
import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/data/database/providers/padi_user_table_provider.dart';
import 'package:padi/modules/attendance/record/infra/models/attendance_check_out_model.dart';

class AttendanceCheckOutServices {

  PadiUserTableDataProvider padiUserTableProvider = PadiUserTableDataProvider();

  Future<AttendanceCheckOutModel> checkOut(
      CheckOutBodyRequest body,
      String? attendanceId
      ) async {

    ApiRequest apiRequest = ApiRequest();

    final token = await padiUserTableProvider.getUserToken();

    final response = await apiRequest.post(
      '/checkout/$attendanceId',
        json.encode(body.toJson()),
      token
    );

    if (response.statusCode == 200) {
      return AttendanceCheckOutModel.fromJson(json.decode(response.body));
    } else {
      throw Exception;
    }
  }

}