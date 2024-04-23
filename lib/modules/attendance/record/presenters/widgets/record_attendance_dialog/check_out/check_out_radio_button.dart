import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/attendance_radio_button.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/attendance_radio_button_state_provider.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/attendance_radio_button_value_state_provider.dart';

class CheckOutRadioButton extends ConsumerWidget {
  const CheckOutRadioButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(radioButtonValueStateProvider.notifier);
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AttendanceRadioButton(
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
            child: AttendanceRadioButton(
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
