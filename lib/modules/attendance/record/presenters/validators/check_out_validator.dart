import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/validators/validators.dart';
import 'package:padi/modules/attendance/record/attendance_check_out_provider.dart';
import 'package:padi/modules/attendance/record/infra/models/attendance_check_out_model.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/attendance_radio_button_value_state_provider.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/check_out/record_check_out_alert_dialog.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/loading_alert_dialog.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/messenger_alert_dialog.dart';
import 'package:padi/modules/shared/presenters/date_and_time/date_and_time_provider.dart';
import 'package:padi/modules/shared/presenters/location/user/user_location_state_provider.dart';

import '../../../../../core/utils/shared_preferences.dart';

void checkOutValidator(
    BuildContext context,
    String? attendanceId,
    CheckOutType checkOutType,
    DateTimeProvider dateTimeProvider,
    UserLocationStateNotifier userLocationStateNotifier,
    TextEditingController activityController,
    RadioButtonValueStateProvider radioButtonValueStateProvider,
    AttendanceCheckOutProvider attendanceCheckOutProvider,
    void Function() onCheckOutSuccess,
) {

  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  final coordinates = userLocationStateNotifier.getUserCoordinates();

  String timestamp = dateTimeProvider.getTimestamp();
  String localTime = dateTimeProvider.getLocalTime();

  final lat = coordinates['latitude'].toString();
  final long = coordinates['longitude'].toString();

  String status = 'CHECKOUT';

  String progressType = radioButtonValueStateProvider.getProgressType;

  String activity = activityController.text;

  bool allEmpty = activity.isEmpty && progressType.isEmpty;

  final field = Validator.validateCheckOut(timestamp, lat, long, status, progressType);
  final progressTypeAndActivityField = Validator.validateProgressTypeAndActivity(progressType, activity);

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

  if (field != null) {
    bool error = false;
    showMessengerAlertDialog(
        context,
        field,
        error,
            () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
    return;
  }

  CheckOutBodyRequest body = CheckOutBodyRequest(
      checkOutTime: timestamp,
      latitude: lat,
      longitude: long,
      status: status,
      progressType: progressType,
      activity: activity,
  );

  showLoadingAlertDialog(
      context,
      Strings.checkingOut
  );

  attendanceCheckOutProvider.checkOut(
      body,
      attendanceId
  ).then(( attendanceCheckOut) {
    Navigator.of(context, rootNavigator: true).pop();
    bool success = true;

    if (checkOutType == CheckOutType.checkOut) prefs.savePrefs(PrefsKey.attendanceCheckOutTime, localTime);

    onCheckOutSuccess();

    showMessengerAlertDialog(
        context,
        Strings.checkOutSuccess,
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
        Strings.failToCheckOut,
        error,
            () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
  });

}