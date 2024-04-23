import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'shared_preferences.dart';

class AppNotifications {
  static final onClickNotification = BehaviorSubject<String>();

  static void onTapNotification(NotificationResponse response) {
    onClickNotification.add(response.payload!);
  }

  static void onBackgroundNotification(NotificationResponse response) {
    onClickNotification.add(response.payload!);
  }

  static Future initNotification() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) async {

        });
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onTapNotification);
  }

  static requestPermissions() async {
    final prefs = SharedPreferencesUtils();

    final bool isNotificationPermissionRequested = await prefs.getPrefs(PrefsKey.isNotificationPermissionRequested) ?? false;

    if (!isNotificationPermissionRequested) {
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

      await prefs.savePrefs(PrefsKey.isNotificationPermissionRequested, true);
    }
  }

  static void showNotifications(
      String title,
      String body,
      String payload,
      String channelId,
      String channelName,
      tz.TZDateTime scheduledDate,
      ) async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        title,
        body,
        scheduledDate.add(const Duration(seconds: 5)),
      NotificationDetails(
          android: AndroidNotificationDetails(
            channelId,
            channelName,
            importance: Importance.max,
            priority: Priority.high,
            showWhen: false,
            playSound: true,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          )
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        payload: payload,
    );
  }

  static void showCheckInNotifications() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

    final prefs = SharedPreferencesUtils();
    final isLoggedIn = await prefs.getPrefs(PrefsKey.isLoggedIn) ?? false;
    final showNotifications = await prefs.getPrefs(PrefsKey.showNotifications) ?? false;
    final showCheckInReminderNotification = await prefs.getPrefs(PrefsKey.showCheckInReminderNotification) ?? false;

    if (isLoggedIn) {
      if (showNotifications && showCheckInReminderNotification) {
        final isCheckedIn = await prefs.getPrefs(PrefsKey.isCheckedIn) ?? false;
        final isCheckInNotificationShown = await prefs.getPrefs(PrefsKey.isCheckInReminderShown) ?? false;
        final checkInReminderTime = await prefs.getPrefs(PrefsKey.checkInReminderTime);
        final checkInReminderTimeSplit = checkInReminderTime.split(':');
        final checkInReminderHour = int.parse(checkInReminderTimeSplit[0]);
        final checkInReminderMinute = int.parse(checkInReminderTimeSplit[1]);

        final now = tz.TZDateTime.now(tz.local);
        var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, checkInReminderHour, checkInReminderMinute);

        if (now.isAfter(scheduledDate)) {
          scheduledDate = scheduledDate.add(const Duration(days: 1));
        }

        if (isCheckedIn == false && isCheckInNotificationShown == false) {
          AppNotifications.showNotifications(
            NotificationsData.checkInReminderTitle,
            NotificationsData.checkInReminderBody,
            NotificationsData.checkInReminderPayload,
            NotificationsData.checkInReminderChannelId,
            NotificationsData.checkInReminderChannelName,
            scheduledDate,
          );
        }
      }
    }
  }

  static void showCheckOutNotifications() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

    final prefs = SharedPreferencesUtils();
    final isLoggedIn = await prefs.getPrefs(PrefsKey.isLoggedIn) ?? false;
    final showNotifications = await prefs.getPrefs(PrefsKey.showNotifications) ?? false;
    final showCheckOutReminderNotification = await prefs.getPrefs(PrefsKey.showCheckOutReminderNotification) ?? false;

    if (isLoggedIn) {
      if (showNotifications && showCheckOutReminderNotification) {
        final isCheckedOut = await prefs.getPrefs(PrefsKey.isCheckedOut) ?? false;
        final isCheckOutNotificationShown = await prefs.getPrefs(PrefsKey.isCheckOutReminderShown) ?? false;
        final checkOutReminderTime = await prefs.getPrefs(PrefsKey.checkOutReminderTime);
        final checkOutReminderTimeSplit = checkOutReminderTime.split(':');
        final checkOutReminderHour = int.parse(checkOutReminderTimeSplit[0]);
        final checkOutReminderMinute = int.parse(checkOutReminderTimeSplit[1]);

        var now = tz.TZDateTime.now(tz.local);
        var scheduledDate = tz.TZDateTime(
            tz.local,
            now.year,
            now.month,
            now.day,
            checkOutReminderHour,
            checkOutReminderMinute
        );

        if (now.isAfter(scheduledDate)) {
          scheduledDate = scheduledDate.add(const Duration(days: 1));
        }

        if (isCheckedOut == false && isCheckOutNotificationShown == false) {
          AppNotifications.showNotifications(
            NotificationsData.checkOutReminderTitle,
            NotificationsData.checkOutReminderBody,
            NotificationsData.checkOutReminderPayload,
            NotificationsData.checkOutReminderChannelId,
            NotificationsData.checkOutReminderChannelName,
            scheduledDate,
          );
        }
      }
    }

  }

}

class NotificationsData {
  NotificationsData._();

  static const String checkInReminderChannelId = 'checkInReminderChannelId';
  static const String checkInReminderChannelName = 'checkInReminderChannelName';
  static const String checkInReminderTitle = 'Bentar Lagi Jadwal Masuk';
  static const String checkInReminderBody = 'Jangan Lupa Mencatat Kehadiran Ya!';
  static const String checkInReminderPayload = 'checkIn';

  static const String checkOutReminderChannelId = 'checkOutReminderChannelId';
  static const String checkOutReminderChannelName = 'checkOutReminderChannelName';
  static const String checkOutReminderTitle = 'Udah Waktunya Pulang Nih';
  static const String checkOutReminderBody = 'Jangan Lupa Mencatat Kepulangan Ya!';
  static const String checkOutReminderPayload = 'checkOut';
}