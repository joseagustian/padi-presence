import 'package:padi/modules/settings/domains/entities/app_log_entity.dart';
import 'package:padi/modules/settings/infra/sources/app_log_services.dart';

class AppLogUseCase {

  final AppLogServices _appLogServices;

  AppLogUseCase(this._appLogServices);

  Future<ApplicationLogs> getLogs() async {
    final logs = await _appLogServices.getLogs();

    final applicationLogs = ApplicationLogs(
      logs: logs.data.map((log) => ApplicationLogData(
        logId: log.logId,
        time: log.time,
        log: log.log,
        type: log.type,
      )).toList(),
    );

    return applicationLogs;
  }

}