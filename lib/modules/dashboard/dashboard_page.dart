import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/utils/app_logger.dart';
import 'package:padi/modules/dashboard/presenters/widgets/announcement_widget.dart';
import 'package:padi/modules/dashboard/presenters/widgets/dashboard_appbar.dart';
import 'package:padi/modules/dashboard/presenters/widgets/today_activity_widget.dart';
import 'package:padi/modules/shared/presenters/employee_data_card/employee_data_card.dart';

import 'presenters/widgets/monthly_activity_summary.dart';
import 'working_time_summary_provider.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final AppLogger logger = AppLogger();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DashboardAppBar(),
            Expanded(
              child: RefreshIndicator(
                backgroundColor: Colors.blueGrey.shade800,
                color: Colors.blueGrey.shade100,
                onRefresh: () async {
                  ref.refresh(monthlyActivitySummaryProvider.notifier).getWorkingTimeSummary();
                  logger.recordLog(LoggerMessage.refreshWorkingTimeSummary, LogType.info);
                },
                child: const SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      EmployeeDataCard(),
                      AnnouncementWidget(),
                      TodayActivityWidget(),
                      MonthlyActivitySummary(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
