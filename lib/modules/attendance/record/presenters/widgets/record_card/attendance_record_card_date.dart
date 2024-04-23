import 'package:flutter/material.dart';

class AttendanceRecordCardDate extends StatelessWidget {
  final String date;

  const AttendanceRecordCardDate({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            date,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade700,
            ),
          ),
        ],
      );
  }
}
