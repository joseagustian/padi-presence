import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/utils/app_logger.dart';
import 'package:padi/modules/attendance/record/attendance_by_id_provider.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_card/attendance_record_card_state_provider.dart';
import 'package:padi/modules/dashboard/presenters/widgets/announcement_widget.dart';
import 'package:padi/modules/dashboard/presenters/widgets/dashboard_appbar.dart';
import 'package:padi/modules/dashboard/presenters/widgets/today_activity_widget.dart';
import 'package:padi/modules/dashboard/today_activity_provider.dart';
import 'package:padi/modules/shared/presenters/employee_data_card/employee_data_card.dart';

import 'presenters/widgets/monthly_activity_summary.dart';
import 'working_time_summary_provider.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {


  @override
  Widget build(BuildContext context) {
    ref.watch(getAttendanceDataByIDProvider("")).setLastAttendanceButton();
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
                  ref.refresh(getAttendanceDataByIDProvider("")).setLastAttendanceButton();
                  ref.refresh(monthlyActivitySummaryProvider.notifier).getWorkingTimeSummary();
                  ref.refresh(todayActivityProvider.notifier).getTodayActivity();
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
