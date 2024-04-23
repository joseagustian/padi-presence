import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/attendance_radio_button.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/attendance_radio_button_state_provider.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/attendance_radio_button_value_state_provider.dart';
import 'package:padi/modules/shared/presenters/location/office/office_distance_provider.dart';

class CheckInRadioButton extends ConsumerWidget {
  const CheckInRadioButton({
    super.key
  });

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(radioButtonValueStateProvider.notifier);
    final distance = ref.watch(officeDistanceProvider);
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AttendanceRadioButton(
              title: Strings.checkInFromOffice,
              groupValue: ref.watch(attendanceWorkTypeProvider),
              value: AttendanceWorkType.wfo,
              provider: attendanceWorkTypeProvider,
              onChanged: () {
                state.setWorkType(Strings.wfo);
              },
              enabled: distance.value != null && distance.value! <= 0.2,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: AttendanceRadioButton(
                title: Strings.checkInFromHome,
                groupValue: ref.watch(attendanceWorkTypeProvider),
                value: AttendanceWorkType.wfh,
                provider: attendanceWorkTypeProvider,
                onChanged: () {
                  state.setWorkType(Strings.wfh);
                },
                enabled: true,
            ),
          ),
        ],
      ),
    );
  }
}
