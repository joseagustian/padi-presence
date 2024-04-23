import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_list/record_history_working_hours.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_list/record_history_attendance_date.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_list/record_history_attendance_time.dart';

enum WorkType {
  wfo,
  wfh,

}

class AttendanceRecordHistoryCard extends StatelessWidget {
  final WorkType workType;
  final String date;
  final String day;
  final String checkInClock;
  final String checkOutClock;
  final String activity;
  final String workingHours;
  final void Function() onTap;
  final void Function() onCheckoutTap;

  const AttendanceRecordHistoryCard({
    super.key,
    required this.workType,
    required this.date,
    required this.day,
    required this.checkInClock,
    required this.checkOutClock,
    required this.activity,
    required this.workingHours,
    required this.onTap,
    required this.onCheckoutTap
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RecordHistoryAttendanceDate(
              date: date,
              day: day
          ),
          const SizedBox(width: 5),
          Icon(
            workType == WorkType.wfo ?
            Bootstrap.building : Icons.home_work_outlined,
            size: 16,
            color: Colors.blueGrey.shade700,
          ),
          const SizedBox(width: 15),
          RecordHistoryAttendanceTime(
              checkInTime: checkInClock,
              checkOutTime: checkOutClock,
              isCheckedOut: checkOutClock == '--:--' ? false : true,
              onCheckoutTap: onCheckoutTap
          ),
          const SizedBox(width: 15),
          RecordHistoryWorkingHours(
              text: workingHours
          ),
          InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade700,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: const Icon(
                EvaIcons.external_link,
                size: 16,
                color: Colors.white,
              ),
            ),
          ),
        ]
    );
  }
}
