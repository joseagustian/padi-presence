import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/attendance/record/attendance_check_in_provider.dart';
import 'package:padi/modules/attendance/record/attendances_history_provider.dart';
import 'package:padi/modules/attendance/record/presenters/validators/check_in_validator.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/attendance_dialog_button.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/attendance_radio_button_value_state_provider.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/check_in/check_in_radio_button.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_card/attendance_record_card_state_provider.dart';
import 'package:padi/modules/shared/presenters/date_and_time/date_and_time_provider.dart';
import 'package:padi/modules/shared/presenters/location/user/user_location_state_provider.dart';
import 'package:padi/modules/shared/presenters/maps/attendance_maps_widget.dart';

class RecordCheckInAlertDialog extends ConsumerWidget {

  const RecordCheckInAlertDialog({
    super.key
  });


  @override
  Widget build(BuildContext context, ref) {
    return AlertDialog(
      surfaceTintColor: Colors.blueGrey.shade200,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
            Radius.circular(10.0)
        ),
      ),
      insetPadding: const EdgeInsets.all(15.0),
      contentPadding: const EdgeInsets.all(20.0),
      clipBehavior: Clip.antiAlias,
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width * 1,
          minHeight: MediaQuery.of(context).size.height * 0.3,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.recordCheckIn,
              style: TextStyle(
                  color: Colors.blueGrey[900],
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 10.0),
            AttendanceMapsWidget(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.25,
              type: AttendanceType.checkIn,
            ),
            const SizedBox(height: 10.0),
            const CheckInRadioButton(),
            const SizedBox(height: 10.0),
            AttendanceDialogButton(
              onPressed: () {
                validateCheckIn(
                    context,
                    ref.watch(dateTimeProvider),
                    ref.watch(userLocationStateProvider.notifier),
                    ref.watch(radioButtonValueStateProvider.notifier),
                    ref.watch(attendanceCheckInProvider),
                        () {
                      ref.refresh(attendancesHistoryProvider).value;
                      ref.read(recordCardStateProvider.notifier).setAttendanceButtonState();
                    }
                );
              },
              title: Strings.checkIn,
            ),
          ],
        ),
      ),
    );
  }
}

void showRecordCheckInAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const RecordCheckInAlertDialog();
    }
  );
}
