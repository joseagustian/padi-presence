import 'package:flutter/material.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_card/attendance_record_card.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_list/attendance_record_history_list.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_list/record_history_list_header.dart';


import 'presenters/widgets/attendance_record_appbar.dart';

class AttendanceRecordPage extends StatelessWidget {
  const AttendanceRecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AttendanceRecordAppBar(),
            AttendanceRecordCard(),
            RecordHistoryListHeader(),
            AttendanceRecordHistoryList()
          ],
        ),
      ),
    );
  }
}
