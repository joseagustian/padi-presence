import 'package:flutter/material.dart';

class RecordHistoryNoAttendanceDate extends StatelessWidget {
  final String date;
  final String day;
  final bool isDayOff;
  const RecordHistoryNoAttendanceDate({
    super.key,
    required this.date,
    required this.day,
    required this.isDayOff
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            date.substring(0, 2),
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isDayOff ? Colors.red.shade700 : Colors.blueGrey.shade700
            ),
          ),
          Text(
            day.toUpperCase(),
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isDayOff ? Colors.red.shade700 : Colors.blueGrey.shade700
            ),
          ),
        ],
      ),
    );
  }
}
