

import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/data/database/providers/padi_user_table_provider.dart';
import 'package:padi/modules/dashboard/infra/models/monthly_activity_model.dart';
import 'package:padi/modules/shared/presenters/date_and_time/date_and_time_provider.dart';

class MonthlyActivityServices {
  DateTimeProvider dateTimeProvider = DateTimeProvider();
  PadiUserTableDataProvider padiUserTableProvider = PadiUserTableDataProvider();

  Future<MonthlyActivityModel> getMonthlyActivity() async {
    ApiRequest apiRequest = ApiRequest();

    final period = dateTimeProvider.getMonthNumberAndYear();
    final token = await padiUserTableProvider.getUserToken();

    final response = await apiRequest.get(
      '/monthly-activity/$period',
      token,
    );

    if (response.statusCode == 200) {
      return MonthlyActivityModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(Strings.failToLoadMonthlyActivity);
    }

  }
}