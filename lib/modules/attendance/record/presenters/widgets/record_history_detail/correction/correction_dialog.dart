import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/attendance/record/attendance_correction_provider.dart';
import 'package:padi/modules/attendance/record/attendance_history_detail_provider.dart';
import 'package:padi/modules/attendance/record/presenters/validators/correction_validator.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/attendance_radio_button_value_state_provider.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_detail/correction/correction_dialog_button.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_detail/correction/correction_radio_button.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_detail/correction/correction_textfield.dart';

class CorrectionDialog extends ConsumerStatefulWidget {
  final String attendanceId;
  const CorrectionDialog({
    super.key,
    required this.attendanceId,
  });

  @override
  ConsumerState<CorrectionDialog> createState() => _CorrectionDialogState();
}

class _CorrectionDialogState extends ConsumerState<CorrectionDialog> {
  final activityCorrectionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.blueGrey.shade200,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(10.0)
        ),
      ),
      insetPadding: const EdgeInsets.all(15.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.correction,
            style: TextStyle(
                color: Colors.blueGrey[900],
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 20.0),
          CorrectionTextField(
            activityController: activityCorrectionController,
          ),
          const SizedBox(height: 10.0),
          const CorrectionRadioButton(),
          const SizedBox(height: 20.0),
          CorrectionDialogButton(
            onPressed: () {
              correctionValidator(
                  context,
                  widget.attendanceId,
                  activityCorrectionController,
                  ref.watch(radioButtonValueStateProvider.notifier),
                  ref.watch(attendanceCorrectionProvider),
                      () {
                    ref.refresh(attendanceHistoryDetailProvider(widget.attendanceId));
                  }
              );
            },
            title: Strings.submitCorrectionData,
          )
        ],
      ),
    );
  }
}

void showCorrectionDialog(
    BuildContext context,
    String attendanceId,
    ) {
  showDialog(
    context: context,
    builder: (context) {
      return CorrectionDialog(
        attendanceId: attendanceId,
      );
    }
  );
}
