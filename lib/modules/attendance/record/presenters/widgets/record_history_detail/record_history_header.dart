import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';

class RecordHistoryDetailHeader extends StatelessWidget {
  const RecordHistoryDetailHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.blueGrey.shade50,
            width: 1.0,
          ),
          bottom: BorderSide(
            color: Colors.blueGrey.shade50,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            Strings.attendanceDetail,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
