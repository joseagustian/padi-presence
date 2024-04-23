import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/attendance/record/attendance_check_out_provider.dart';
import 'package:padi/modules/attendance/record/attendances_history_provider.dart';
import 'package:padi/modules/attendance/record/presenters/validators/check_out_validator.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/attendance_dialog_button.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/attendance_radio_button_value_state_provider.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/check_out/check_out_textfield.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_card/attendance_record_card_state_provider.dart';
import 'package:padi/modules/shared/presenters/date_and_time/date_and_time_provider.dart';
import 'package:padi/modules/shared/presenters/location/user/user_location_state_provider.dart';
import 'package:padi/modules/shared/presenters/maps/attendance_maps_widget.dart';

import 'check_out_radio_button.dart';

class RecordCheckOutAlertDialog extends ConsumerStatefulWidget {
  final String? attendanceId;

  const RecordCheckOutAlertDialog({
    super.key,
    this.attendanceId,
  });

  @override
  ConsumerState<RecordCheckOutAlertDialog> createState() => _RecordCheckOutAlertDialogState();
}

class _RecordCheckOutAlertDialogState extends ConsumerState<RecordCheckOutAlertDialog> {

  final activityController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.3,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.recordCheckOut,
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
                type: AttendanceType.checkOut,
              ),
              const SizedBox(height: 10.0),
              CheckOutTextField(
                activityController: activityController,
              ),
              const SizedBox(height: 10.0),
              const CheckOutRadioButton(),
              const SizedBox(height: 10.0),
              AttendanceDialogButton(
                onPressed: () {
                  checkOutValidator(
                      context,
                      widget.attendanceId,
                      ref.watch(dateTimeProvider),
                      ref.watch(userLocationStateProvider.notifier),
                      activityController,
                      ref.watch(radioButtonValueStateProvider.notifier),
                      ref.watch(attendanceCheckOutProvider),
                          () {
                        ref.refresh(attendancesHistoryProvider).value;
                        ref.read(recordCardStateProvider.notifier).setAttendanceButtonState();
                      }
                  );
                },
                title: Strings.checkOut,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showRecordCheckOutAlertDialog(
    BuildContext context,
    String? attendanceId,
    ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return RecordCheckOutAlertDialog(
        attendanceId: attendanceId,
      );
    },
  );
}
