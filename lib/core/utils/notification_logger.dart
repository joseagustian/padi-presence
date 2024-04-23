
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:padi/core/constants/constant.dart';
import 'package:padi/core/utils/shared_preferences.dart';

enum NotificationType {
  attendanceReminder,
  announcement,
}

class NotificationLogger {
  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  String generateNotificationId() {
    const String chars = CHAR;
    final random = Random();

    List<String> chunks = [];

    for (var i = 0; i < 5; i++) {
      String chunk = String.fromCharCodes(
        List.generate(
          4,
              (_) => chars.codeUnitAt(random.nextInt(chars.length)),
        ),
      );
      chunks.add(chunk);
    }

    return chunks.join('-');
  }

  void recordNotification(String title, String message, NotificationType type) async {
    DateTime now = DateTime.now();
    String notificationRecordTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(now);
    String notification;
    String notificationId = generateNotificationId();

    switch (type) {
      case NotificationType.attendanceReminder:
        notification = '{"notificationId": "$notificationId", "time": "$notificationRecordTime", "title": "$title", "notification": "$message", "type": "attendanceReminder"}';
        break;
      case NotificationType.announcement:
        notification = '{"notificationId": "$notificationId", "time": "$notificationRecordTime", "title": "$title", "notification": "$message", "type": "announcement"}';
        break;
    }

    final existingNotifications = await prefs.getPrefsList(PrefsKey.notificationLogs);
    final newNotifications = [notification, ...existingNotifications];
    await prefs.savePrefs(PrefsKey.notificationLogs, newNotifications);

  }
}