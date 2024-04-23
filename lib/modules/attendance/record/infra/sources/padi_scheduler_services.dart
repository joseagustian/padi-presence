
import 'dart:convert';

import 'package:padi/core/configs/api_config.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/data/database/providers/padi_user_table_provider.dart';
import 'package:padi/modules/attendance/record/infra/models/padi_scheduler_model.dart';

class PadiSchedulerServices {
  PadiUserTableDataProvider padiUserTableProvider = PadiUserTableDataProvider();

  Future<PadiSchedulerModel> runScheduler() async {
    ApiRequest apiRequest = ApiRequest();

    final token = await padiUserTableProvider.getUserToken();

    final response = await apiRequest.get(
      '/schedule',
      token,
    );

    if (response.statusCode == 200 || response.statusCode == 400) {
      return PadiSchedulerModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(Strings.failToRunScheduler);
    }
  }

}