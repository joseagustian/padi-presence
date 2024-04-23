
import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/data/database/providers/padi_user_table_provider.dart';
import 'package:padi/modules/attendance/record/infra/models/attendance_history_detail_model.dart';

class AttendanceHistoryDetailServices {
  PadiUserTableDataProvider padiUserTableProvider = PadiUserTableDataProvider();

  Future<AttendanceHistoryDetailModel> getAttendanceHistoryDetail(String attendanceId) async {
    ApiRequest apiRequest = ApiRequest();

    final token = await padiUserTableProvider.getUserToken();

    final response = await apiRequest.get(
      '/transaction/$attendanceId',
      token,
    );

    if (response.statusCode == 200) {
      return AttendanceHistoryDetailModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception;
    }

  }

}