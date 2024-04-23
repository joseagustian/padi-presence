import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/utils/app_logger.dart';
import 'package:padi/modules/settings/app_log_provider.dart';
import 'package:padi/modules/settings/domains/entities/app_log_entity.dart';

import 'app_log_card.dart';
import 'app_log_filter_state_provider.dart';

class AppLogList extends ConsumerWidget {
  const AppLogList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final filter = ref.watch(appLogFilterProvider);
    return Expanded(
      child: ref.watch(appLogProvider).when(
          data: (data) {

            List<ApplicationLogData> filteredLogs;

            if (filter.filterType == AppLogFilterType.all) {
              filteredLogs = data.logs;
            } else if (filter.filterType == AppLogFilterType.info) {
              filteredLogs = data.logs.where((element) => element.type == "info").toList();
            } else if (filter.filterType == AppLogFilterType.warning) {
              filteredLogs = data.logs.where((element) => element.type == "warning").toList();
            } else if (filter.filterType == AppLogFilterType.error) {
              filteredLogs = data.logs.where((element) => element.type == "error").toList();
            } else {
              filteredLogs = data.logs;
            }

            if (filteredLogs.isEmpty) {
              return Center(child: Text(
                  Strings.noAppLogsData,
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey.shade900
                  )
              ));
            } else {
              return RawScrollbar(
                thumbVisibility: true,
                trackVisibility: true,
                thumbColor: Colors.blueGrey[900],
                trackColor: Colors.blueGrey[300],
                thickness: 3,
                padding: const EdgeInsets.only(right: 2),
                child: RefreshIndicator(
                  backgroundColor: Colors.blueGrey.shade800,
                  color: Colors.blueGrey.shade100,
                  onRefresh: () async {
                    ref.refresh(getAppLogProvider).getAppLog();
                  },
                  child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filteredLogs.length,
                      itemBuilder: (context, index) {
                        return AppLogCard(
                          logTime: filteredLogs[index].time,
                          logMessage: filteredLogs[index].log,
                          logType: filteredLogs[index].type == "info" ?
                          LogType.info : filteredLogs[index].type == "warning" ?
                          LogType.warning : LogType.error,
                        );
                      }
                  ),
                ),
              );
            }
          },
          error: (e, s) {
            return Center(child: Text(
                e.toString(),
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey.shade900
                )
            ));
          },
          loading: () => Center(
              child: SizedBox(
                width: 50.0,
                child: LoadingIndicator(
                    indicatorType: Indicator.ballSpinFadeLoader,
                    colors: [
                      Colors.blueGrey.shade600,
                      Colors.blueGrey.shade800,
                      Colors.blueGrey.shade600,
                      Colors.blueGrey.shade800,
                    ]
                ),
              )
          )
      )
    );
  }
}
