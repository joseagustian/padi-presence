import 'package:shared_preferences/shared_preferences.dart';

class PrefsKey {
  static const String isLoggedIn = 'isLoggedIn';
  static const String isCheckedIn = 'isCheckedIn';
  static const String isCheckedOut = 'isCheckedOut';
  static const String lastAttendanceTime = 'lastAttendanceTime';
  static const String recentAttendanceId = 'recentAttendanceId';
  static const String applicationLogs = 'applicationLogs';
  static const String isNotificationPermissionRequested = 'isNotificationPermissionRequested';
  static const String showNotifications = 'showNotifications';
  static const String showCheckInReminderNotification = 'showCheckInReminderNotification';
  static const String showCheckOutReminderNotification = 'showCheckOutReminderNotification';
  static const String checkInReminderTime = 'checkInReminderTime';
  static const String checkOutReminderTime = 'checkOutReminderTime';
  static const String isCheckInReminderShown = 'isCheckInReminderShown';
  static const String isCheckOutReminderShown = 'isCheckOutReminderShown';
  static const String notificationLogs = 'notificationLogs';
  static const String attendanceCheckInTime = 'attendanceCheckInTime';
  static const String attendanceCheckOutTime = 'attendanceCheckOutTime';
  static const String attendanceWorkingHours = 'attendanceWorkingHours';
}


class SharedPreferencesUtils {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    Future<void> savePrefs(String key, dynamic value) async {

      final prefs = await _prefs;
      if (value is String) {
        await prefs.setString(key, value);
      } else if (value is int) {
        await prefs.setInt(key, value);
      } else if (value is double) {
        await prefs.setDouble(key, value);
      } else if (value is bool) {
        await prefs.setBool(key, value);
      } else if (value is List<String>) {
        await prefs.setStringList(key, value);
      }

    }

    Future<dynamic> getPrefs(String key) async {
      final prefs = await _prefs;
      final dynamic value = prefs.get(key);
      return value;
    }

    Future<List<String>> getPrefsList(String key) async {
      final prefs = await _prefs;
      final List<String> value = prefs.getStringList(key) ?? [];
      return value;
    }

    Future<void> removePrefs(String key) async {
      final prefs = await _prefs;
      await prefs.remove(key);
    }

    Future<void> clearPrefs() async {
      final prefs = await _prefs;
      await prefs.clear();
    }


}