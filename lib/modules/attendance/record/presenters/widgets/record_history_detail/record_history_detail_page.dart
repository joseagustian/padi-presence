import 'package:flutter/material.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_detail/correction/correction_dialog.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_detail/record_history_detail.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_detail/record_history_edit_button.dart';
import 'package:padi/modules/shared/presenters/employee_data_card/employee_data_card.dart';

import 'record_history_detail_appbar.dart';
import 'record_history_header.dart';

class RecordHistoryDetailPage extends StatelessWidget {
  final String? attendanceId;
  const RecordHistoryDetailPage({
    super.key,
    this.attendanceId
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const RecordHistoryDetailAppBar(),
            const EmployeeDataCard(),
            const RecordHistoryDetailHeader(),
            RecordHistoryDetail(
              attendanceId: attendanceId,
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 1,
              offset: const Offset(0, -1),
            )
          ],
        ),
        child: RecordHistoryEditButton(
          onPressed: () {
            showCorrectionDialog(context, attendanceId!);
          },
        ),
      ),
    );
  }
}
