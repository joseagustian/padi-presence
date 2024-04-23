import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';


enum Type {
  checkIn,
  checkOut,
}

class AttendanceRecordCardTime extends StatelessWidget {
  final Type type;
  final String time;
  const AttendanceRecordCardTime({
    super.key,
    required this.type,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: type == Type.checkIn ? Row(
        children: [
          Transform.flip(
            flipX: true,
            child: Icon(
              BoxIcons.bx_time_five,
              color: Colors.blueGrey.shade50,
            ),
          ),
          const SizedBox(width: 10.0),
          Text(
            time,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade50,
            ),
          )
        ],
      ) : Row(
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade50,
            ),
          ),
          const SizedBox(width: 10.0),
          Icon(
            BoxIcons.bx_time_five,
            color: Colors.blueGrey.shade50
          ),
        ],
      ),
    );
  }
}
