import 'package:flutter/material.dart';

class RecordHistoryAttendanceDate extends StatelessWidget {
  final String date;
  final String day;

  const RecordHistoryAttendanceDate({
    super.key,
    required this.date,
    required this.day
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
                color: Colors.blueGrey.shade700
            ),
          ),
          Text(
            day.toUpperCase(),
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade700
            ),
          ),
        ],
      ),
    );
  }
}
