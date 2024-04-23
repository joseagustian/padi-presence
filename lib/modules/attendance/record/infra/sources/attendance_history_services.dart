
import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/data/database/providers/padi_user_table_provider.dart';
import 'package:padi/modules/attendance/record/infra/models/attendance_history_model.dart';
import 'package:padi/modules/shared/presenters/date_and_time/date_and_time_provider.dart';

class AttendancesHistoryServices {

  DateTimeProvider dateTimeProvider = DateTimeProvider();
  PadiUserTableDataProvider padiUserTableDataProvider = PadiUserTableDataProvider();

  Future<AttendancesHistoryModel> getAttendanceHistory() async {
    ApiRequest apiRequest = ApiRequest();

    final period = dateTimeProvider.getMonthNumberAndYear();
    final token = await padiUserTableDataProvider.getUserToken();

    final response = await apiRequest.get(
      '/transaction/$period',
      token,
    );

    if (response.statusCode == 200) {
      return AttendancesHistoryModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception;
    }

  }

}