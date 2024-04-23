import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/modules/dashboard/presenters/widgets/absence_summary_widget.dart';
import 'package:padi/modules/dashboard/presenters/widgets/late_summary_widget.dart';
import 'package:padi/modules/dashboard/presenters/widgets/working_day_summary_widget.dart';
import 'package:padi/modules/dashboard/presenters/widgets/working_hour_summary_widget.dart';
import 'package:padi/modules/dashboard/working_time_summary_provider.dart';

import 'leave_summary_widget.dart';
import 'work_location_summary_widget.dart';

class MonthlyActivitySummary extends ConsumerWidget {
  const MonthlyActivitySummary({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(monthlyActivitySummaryProvider);
    return Column(
      children: [
        Row(
          children: [
            WorkingDaySummaryWidget(
                targetWorkingDays: state.standardWorkingDay,
                completedWorkingDays: state.employeeWorkingDay,
                isLoading: state.isLoading
            ),
            const SizedBox(width: 10),
            WorkingHourSummaryWidget(
                targetWorkingHours: state.standardWorkingHour,
                completedWorkingHours: state.employeeWorkingHour,
                isLoading: state.isLoading
            )
          ],
        ),
        Row(
          children: [
            AbsenceSummaryWidget(
              absence: state.notPresentDay,
              isLoading: state.isLoading,
            ),
            const SizedBox(width: 10),
            LateSummaryWidget(
              late: state.lateDay,
              isLoading: state.isLoading,
            )
          ],
        ),
        Row(
            children: [
              WorkLocationSummaryWidget(
                  wfh: state.workFromHomeDay,
                  wfo: state.workFromOfficeDay,
                  isLoading: state.isLoading
              ),
              const SizedBox(width: 10),
              LeaveSummaryWidget(
                leaveDay: state.leaveDay,
                isLoading: state.isLoading,
              )
            ]
        ),
      ],
    );
  }
}
