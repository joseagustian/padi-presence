
import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/data/database/providers/padi_user_table_provider.dart';

import '../models/attendance_by_id_model.dart';

class AttendanceDataByIDServices {
  PadiUserTableDataProvider padiUserTableProvider = PadiUserTableDataProvider();

  Future<AttendanceDataByIDModel> getAttendanceDataByID(String attendanceId) async {
    ApiRequest apiRequest = ApiRequest();

    final token = await padiUserTableProvider.getUserToken();

    final response = await apiRequest.get(
      '/transaction/$attendanceId',
      token,
    );

    if (response.statusCode == 200) {
      return AttendanceDataByIDModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 500) {
      return AttendanceDataByIDModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load attendance data');
    }

  }

}