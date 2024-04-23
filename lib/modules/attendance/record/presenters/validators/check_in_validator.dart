import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/validators/validators.dart';
import 'package:padi/modules/attendance/record/attendance_check_in_provider.dart';
import 'package:padi/modules/attendance/record/infra/models/attendance_check_in_model.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/attendance_radio_button_value_state_provider.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/loading_alert_dialog.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/messenger_alert_dialog.dart';
import 'package:padi/modules/shared/presenters/date_and_time/date_and_time_provider.dart';
import 'package:padi/modules/shared/presenters/location/user/user_location_state_provider.dart';

void validateCheckIn(
    BuildContext context,
    DateTimeProvider dateTimeProvider,
    UserLocationStateNotifier userLocationStateNotifier,
    RadioButtonValueStateProvider radioButtonValueStateProvider,
    AttendanceCheckInProvider attendanceCheckInProvider,
    void Function() onCheckInSuccess,
) {

  final coordinates = userLocationStateNotifier.getUserCoordinates();


  String timestamp = dateTimeProvider.getTimestamp();

  final lat = coordinates['latitude'].toString();
  final long = coordinates['longitude'].toString();

  String status = 'CHECKIN';

  String workType = radioButtonValueStateProvider.getWorkType;

  final field = Validator.validateCheckIn(timestamp, lat, long, status);
  final workTypeField = Validator.validateWorkType(workType);



  if (workTypeField != null) {
    bool error = false;
    showMessengerAlertDialog(
        context,
        workTypeField,
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

  CheckInBodyRequest body = CheckInBodyRequest(
    checkInTime: timestamp,
    latitude: lat,
    longitude: long,
    status: status,
    workType: workType
  );

  showLoadingAlertDialog(
      context,
      Strings.checkingIn
  );

  attendanceCheckInProvider.checkIn(body).then(( attendanceCheckIn) {
    Navigator.of(context, rootNavigator: true).pop();
    bool success = true;


    onCheckInSuccess();

    showMessengerAlertDialog(
        context,
        Strings.checkInSuccess,
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
        e.toString(),
        error,
        () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
  });
}