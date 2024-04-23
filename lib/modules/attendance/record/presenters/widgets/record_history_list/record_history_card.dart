import 'package:flutter/material.dart';

import 'attendance_record_history_card.dart';
import 'no_attendance_record_history_card.dart';

class RecordHistoryCard extends StatelessWidget {
  final bool isEmptyCard;
  final WorkType workType;
  final String date;
  final String day;
  final String checkInClock;
  final String checkOutClock;
  final String activity;
  final String workingHours;
  final String attendanceDate;
  final String attendanceDay;
  final bool isDayOff;
  final void Function() onTap;
  final void Function() onCheckoutTap;
  const RecordHistoryCard({
    super.key,
    required this.isEmptyCard,
    required this.workType,
    required this.date,
    required this.day,
    required this.checkInClock,
    required this.checkOutClock,
    required this.activity,
    required this.workingHours,
    required this.attendanceDate,
    required this.attendanceDay,
    required this.isDayOff,
    required this.onTap,
    required this.onCheckoutTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0
      ),
      color: isEmptyCard && isDayOff ? Colors.red.shade50 : isEmptyCard ? Colors.blueGrey.shade50 : Colors.white,
      child: isEmptyCard ?
      NoAttendanceRecordHistoryCard(
        date: attendanceDate,
        day: attendanceDay,
        isDayOff: isDayOff,
      ) :
      AttendanceRecordHistoryCard(
        workType: workType,
        date: date,
        day: day,
        checkInClock: checkInClock,
        checkOutClock: checkOutClock,
        activity: activity,
        workingHours: workingHours,
        onTap: onTap,
        onCheckoutTap: onCheckoutTap,
      )
    );
  }
}
