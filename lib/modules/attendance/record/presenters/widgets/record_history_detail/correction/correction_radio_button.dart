import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/attendance_radio_button_state_provider.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/attendance_radio_button_value_state_provider.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_detail/correction/correction_progress_type_radio_button.dart';

class CorrectionRadioButton extends ConsumerWidget {
  const CorrectionRadioButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(radioButtonValueStateProvider.notifier);
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CorrectionProgressTypeRadioButton(
            title: Strings.workOnProgress,
            groupValue: ref.watch(attendanceWorkProgressTypeProvider),
            value: AttendanceWorkProgressType.progress,
            provider: attendanceWorkProgressTypeProvider,
            onChanged: () {
              state.setProgressType(Strings.typeOnProgress);
            },
            enabled: true,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CorrectionProgressTypeRadioButton(
              title: Strings.workFinished,
              groupValue: ref.watch(attendanceWorkProgressTypeProvider),
              value: AttendanceWorkProgressType.finished,
              provider: attendanceWorkProgressTypeProvider,
              onChanged: () {
                state.setProgressType(Strings.typeFinished);
              },
              enabled: true,
            ),
          ),
        ],
      ),
    );
  }
}
