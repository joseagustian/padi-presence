import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';

import 'correction_button_state_provider.dart';

class RecordHistoryEditButton extends ConsumerWidget {
  final Function() onPressed;

  const RecordHistoryEditButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, ref) {
    final attendanceCorrectionButtonState = ref.watch(attendanceCorrectionButtonProvider);
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          backgroundColor: attendanceCorrectionButtonState.isFinished ? Colors.blueGrey.shade700 : Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: attendanceCorrectionButtonState.isFinished ? onPressed : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.attendanceCorrection.toUpperCase(),
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: attendanceCorrectionButtonState.isFinished ? Colors.blueGrey.shade50 : Colors.grey.shade50,
                  fontFamily: 'Gabarito',
                  letterSpacing: 1.5
              ),
            ),
          ],
        )
    );
  }
}
