import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/check_in/record_check_in_alert_dialog.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/check_out/record_check_out_alert_dialog.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_card/attendance_record_card_button.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/location_permission_dialog.dart';
import 'package:padi/modules/shared/presenters/date_and_time/date_and_time_provider.dart';
import 'package:padi/modules/shared/presenters/location/check_location_permission.dart';

import 'attendance_record_card_date.dart';
import 'attendance_record_card_state_provider.dart';

class AttendanceRecordCard extends ConsumerWidget {
  const AttendanceRecordCard({super.key});

  @override
  Widget build(BuildContext context, ref) {

    ref.watch(recordCardStateProvider);

    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1), // changes position of shadow
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AttendanceRecordCardDate(
            date: ref.watch(dateTodayProvider),
          ),
          const SizedBox(height: 15.0),
          AttendanceRecordCardButton(
              type: ref.watch(recordCardStateProvider).type,
              onCheckInTap: () {
                checkLocationPermission().then((value) => {
                  if (value == LocationPermissionStatus.permissionGranted) {
                    showRecordCheckInAlertDialog(context)
                  } else {
                    showLocationPermissionAlertDialog(
                        context,
                        value
                    )
                  }
                });
              },
              onCheckOutTap: () {
                checkLocationPermission().then((value) => {
                  if (value == LocationPermissionStatus.permissionGranted) {
                    showRecordCheckOutAlertDialog(
                        context,
                      null
                    )
                  } else {
                    showLocationPermissionAlertDialog(
                        context,
                        value
                    )
                  }
                });
              },
          ),
        ],
      ),
    );
  }
}
