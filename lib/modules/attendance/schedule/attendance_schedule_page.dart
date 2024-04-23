import 'package:flutter/material.dart';

import 'presenters/widgets/monthly_schedule_appbar.dart';
import 'presenters/widgets/monthly_schedule_calendar.dart';

class MonthlySchedulePage extends StatelessWidget {
  const MonthlySchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MonthlyScheduleAppBar(),
            MonthlyScheduleCalendar(),
          ],
        )
      )
    );
  }
}
