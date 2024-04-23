

import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/validators/validators.dart';
import 'package:padi/modules/attendance/record/attendance_correction_provider.dart';
import 'package:padi/modules/attendance/record/infra/models/attendance_correction_model.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/attendance_radio_button_value_state_provider.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/loading_alert_dialog.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/messenger_alert_dialog.dart';

void correctionValidator(
    BuildContext context,
    String? attendanceId,
    TextEditingController activityCorrectionController,
    RadioButtonValueStateProvider radioButtonValueStateProvider,
    AttendanceCorrectionProvider attendanceCorrectionProvider,
    void Function() onCorrectionSuccess
) {

  String progressType = radioButtonValueStateProvider.getProgressType;
  String correctedActivity =  activityCorrectionController.text;

  bool allEmpty = progressType.isEmpty && correctedActivity.isEmpty;

  final progressTypeAndActivityField = Validator.validateCorrection(progressType, correctedActivity);

  if (allEmpty) {
    bool error = false;
    showMessengerAlertDialog(
        context,
        Strings.makeSureAllFieldsFilled,
        error,
            () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
    return;
  }

  if (progressTypeAndActivityField != null) {
    bool error = false;
    showMessengerAlertDialog(
        context,
        progressTypeAndActivityField,
        error,
            () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
    return;
  }

  AttendanceCorrectionBody body = AttendanceCorrectionBody(
      note: progressType,
      activity: correctedActivity
  );

  showLoadingAlertDialog(
      context,
      Strings.sendCorrectionData
  );

  attendanceCorrectionProvider.correction(
      body,
      attendanceId
  ).then((correction) {
    Navigator.of(context, rootNavigator: true).pop();
    bool success = true;

    onCorrectionSuccess();

    showMessengerAlertDialog(
        context,
        Strings.correctionSuccess,
        success,
            () {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context, rootNavigator: true).pop();
        }
    );

  }).catchError((e) {
    Navigator.of(context, rootNavigator: true).pop();
    bool error = false;
    showMessengerAlertDialog(
        context,
        Strings.failToCorrectingData,
        error,
            () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
  });
}