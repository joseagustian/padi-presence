import 'package:flutter/material.dart';

class AttendanceRecordCardLocation extends StatelessWidget {
  final String location;
  const AttendanceRecordCardLocation({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.near_me_sharp,
          color: Colors.blueGrey.shade50,
          size: 16,
        ),
        const SizedBox(width: 5.0),
        Expanded(
          child: Text(
            location,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.blueGrey.shade50,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
        )
      ],
    );
  }
}
