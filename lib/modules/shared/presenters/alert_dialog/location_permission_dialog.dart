import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/messenger_alert_dialog_button.dart';
import 'package:padi/modules/shared/presenters/location/check_location_permission.dart';

import '../../../../core/constants/strings.dart';

class LocationPermissionDialog extends StatelessWidget {
  final LocationPermissionStatus status;
  const LocationPermissionDialog({
    super.key,
    required this.status
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(15.0),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.3
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              status == LocationPermissionStatus.locationServiceDisabled
                  ? Icons.location_off
                  : status == LocationPermissionStatus.permissionDenied
                  ? Icons.location_disabled : Icons.location_disabled,
              color: Colors.red.shade900,
              size: 80,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Text(
                    Strings.checkLocationAccess,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lato',
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Text(
                    status == LocationPermissionStatus.locationServiceDisabled
                        ? Strings.locationServiceNotActivated
                        : status == LocationPermissionStatus.permissionDenied
                        ? Strings.locationAccessDenied
                        : Strings.locationAccessNotPermitted,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Lato',
                      color: Colors.blueGrey.shade400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            MessengerAlertDialogButton(
                buttonText: Strings.openLocationSetting,
                isSuccess: false,
                onPressed: () {
                  Geolocator.openLocationSettings();
                }
            )
          ],
        ),
      ),
    );
  }
}

void showLocationPermissionAlertDialog(
    BuildContext context,
    LocationPermissionStatus status,
    ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return LocationPermissionDialog(status: status);
    },
  );
}
