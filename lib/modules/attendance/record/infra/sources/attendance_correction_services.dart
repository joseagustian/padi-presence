import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/data/database/providers/padi_user_table_provider.dart';
import 'package:padi/modules/attendance/record/infra/models/attendance_correction_model.dart';

class AttendanceCorrectionServices {

  PadiUserTableDataProvider padiUserTableProvider = PadiUserTableDataProvider();

  Future<AttendanceCorrectionModel> attendanceCorrection(
      AttendanceCorrectionBody body,
      String? attendanceId
      ) async {

    ApiRequest apiRequest = ApiRequest();

    final token = await padiUserTableProvider.getUserToken();

    final response = await apiRequest.post(
      '/correction/$attendanceId',
      jsonEncode(body.toJson()),
      token
    );

    if (response.statusCode == 200) {
      return AttendanceCorrectionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception;
    }

  }

}