import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_list/record_history_no_attendance_date.dart';

class NoAttendanceRecordHistoryCard extends StatelessWidget {
  final String date;
  final String day;
  final bool isDayOff;
  const NoAttendanceRecordHistoryCard({
    super.key,
    required this.date,
    required this.day,
    required this.isDayOff
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RecordHistoryNoAttendanceDate(
            date: date,
            day: day,
            isDayOff: isDayOff
        ),
        const SizedBox(
          height: 36,
        ),
        Expanded(
          child: Text(
            isDayOff ? Strings.dayOff : Strings.absence,
            style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: isDayOff ? Colors.red.shade700 : Colors.blueGrey.shade700
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
