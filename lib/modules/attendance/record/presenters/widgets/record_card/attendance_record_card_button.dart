import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';

enum AttendanceRecordCardButtonType {
  checkIn,
  checkOut,
  todayFinished

}

class AttendanceRecordCardButton extends StatelessWidget {
  final AttendanceRecordCardButtonType type;
  final void Function()? onCheckInTap;
  final void Function()? onCheckOutTap;

  const AttendanceRecordCardButton({
    super.key,
    required this.type,
    required this.onCheckInTap,
    required this.onCheckOutTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          backgroundColor: Colors.blueGrey.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: type == AttendanceRecordCardButtonType.todayFinished ? null :
        type == AttendanceRecordCardButtonType.checkIn ? onCheckInTap : onCheckOutTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              type == AttendanceRecordCardButtonType.todayFinished ? Strings.todayFinished
              : type == AttendanceRecordCardButtonType.checkIn ? Strings.checkIn : Strings.checkOut,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade50,
                  fontFamily: 'Gabarito',
                  letterSpacing: 1.5
              ),
            ),
          ],
        )
    );
  }
}
