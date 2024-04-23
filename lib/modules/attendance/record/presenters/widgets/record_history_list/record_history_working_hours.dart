import 'package:flutter/material.dart';

class RecordHistoryWorkingHours extends StatelessWidget {

  final String text;
  const RecordHistoryWorkingHours({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timer_outlined,
            size: 16,
            color: Colors.blueGrey.shade700,
          ),
          SizedBox(
            width: 70,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade700,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
