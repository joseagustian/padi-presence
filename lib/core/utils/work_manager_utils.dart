
import 'package:workmanager/workmanager.dart';

import 'app_notifications.dart';

void initializeWorkManager() {
  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  scheduleCheckInReminder();
  scheduleCheckOutReminder();
}

void scheduleCheckInReminder() {
  Workmanager().registerPeriodicTask(
    "checkInReminder",
    "sendCheckInNotification",
    frequency: const Duration(hours: 6),
    existingWorkPolicy: ExistingWorkPolicy.update,
  );
}

void scheduleCheckOutReminder() {
  Workmanager().registerPeriodicTask(
    "checkOutReminder",
    "sendCheckOutNotification",
    frequency: const Duration(hours: 6),
    existingWorkPolicy: ExistingWorkPolicy.update,
  );
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case "sendCheckInNotification":
        AppNotifications.showCheckInNotifications();
        break;

      case "sendCheckOutNotification":
        AppNotifications.showCheckOutNotifications();
        break;
    }
    return Future.value(true);
  });
}