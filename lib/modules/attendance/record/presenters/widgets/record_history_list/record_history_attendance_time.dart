import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/strings.dart';

class RecordHistoryAttendanceTime extends StatelessWidget {
  final String checkInTime;
  final String checkOutTime;
  final bool isCheckedOut;
  final void Function() onCheckoutTap;

  const RecordHistoryAttendanceTime({
    super.key,
    required this.checkInTime,
    required this.checkOutTime,
    required this.isCheckedOut,
    required this.onCheckoutTap
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              EvaIcons.diagonal_arrow_right_down,
              size: 18,
              color: Colors.blueGrey.shade700,
            ),
            const SizedBox(width: 5),
            Text(
              checkInTime,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade700
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              EvaIcons.diagonal_arrow_left_up,
              size: 18,
              color: Colors.blueGrey.shade700,
            ),
            const SizedBox(width: 5),
            isCheckedOut ? Text(
              checkOutTime,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade700
              ),
            ) : SizedBox(
              width: 35,
              height: 18,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                    backgroundColor: Colors.blueGrey.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  onPressed: onCheckoutTap,
                  child: Text(
                      Strings.checkOutLowerCase,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade50
                      )
                  )
              ),
            )
          ],
        ),
      ],
    );
  }
}
