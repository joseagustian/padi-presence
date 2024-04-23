
import 'dart:convert';

import 'package:padi/core/utils/shared_preferences.dart';
import 'package:padi/modules/settings/infra/models/app_log_model.dart';

class AppLogServices {
  SharedPreferencesUtils prefs = SharedPreferencesUtils();
  Future<ApplicationLogsModel> getLogs() async {
    final logs = await prefs.getPrefsList(PrefsKey.applicationLogs);
    List<ApplicationLogDataModel> data = [];

    for (var logJson in logs) {
      Map<String, dynamic> logMap = json.decode(logJson);

      ApplicationLogDataModel logData = ApplicationLogDataModel.fromJson(logMap);
      data.add(logData);
    }

    return ApplicationLogsModel(data: data);
  }

}