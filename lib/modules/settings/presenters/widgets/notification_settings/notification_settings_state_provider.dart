

import 'package:app_settings/app_settings.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/utils/shared_preferences.dart';
import 'package:padi/modules/settings/presenters/widgets/notification_settings/check_notification_permission.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationSettingsState {
  bool showNotifications;
  bool showCheckInReminderNotification;
  bool showCheckOutReminderNotification;
  String checkInReminderTime;
  String checkOutReminderTime;
  bool checkInReminderScheduleWidgetVisible;
  bool checkOutReminderScheduleWidgetVisible;

  NotificationSettingsState({
    required this.showNotifications,
    required this.showCheckInReminderNotification,
    required this.showCheckOutReminderNotification,
    required this.checkInReminderTime,
    required this.checkOutReminderTime,
    required this.checkInReminderScheduleWidgetVisible,
    required this.checkOutReminderScheduleWidgetVisible,
  });

  NotificationSettingsState copyWith({
    bool? showNotifications,
    bool? showCheckInReminderNotification,
    bool? showCheckOutReminderNotification,
    String? checkInReminderTime,
    String? checkOutReminderTime,
    bool? checkInReminderScheduleWidgetVisible,
    bool? checkOutReminderScheduleWidgetVisible,
  }) {
    return NotificationSettingsState(
      showNotifications: showNotifications ?? this.showNotifications,
      showCheckInReminderNotification: showCheckInReminderNotification ?? this.showCheckInReminderNotification,
      showCheckOutReminderNotification: showCheckOutReminderNotification ?? this.showCheckOutReminderNotification,
      checkInReminderTime: checkInReminderTime ?? this.checkInReminderTime,
      checkOutReminderTime: checkOutReminderTime ?? this.checkOutReminderTime,
      checkInReminderScheduleWidgetVisible: checkInReminderScheduleWidgetVisible ?? this.checkInReminderScheduleWidgetVisible,
      checkOutReminderScheduleWidgetVisible: checkOutReminderScheduleWidgetVisible ?? this.checkOutReminderScheduleWidgetVisible,
    );
  }

}

class NotificationSettingsStateNotifier extends StateNotifier<NotificationSettingsState> {

  final SharedPreferencesUtils _prefs = SharedPreferencesUtils();
  NotificationSettingsStateNotifier() : super(NotificationSettingsState(
    showNotifications: false,
    showCheckInReminderNotification: false,
    showCheckOutReminderNotification: false,
    checkInReminderTime: '5:00',
    checkOutReminderTime: '16:00',
    checkInReminderScheduleWidgetVisible: false,
    checkOutReminderScheduleWidgetVisible: false,
  )) {
    init();
  }

  void init() async {
    final isNotificationPermissionGranted = await checkNotificationPermission();
    if (isNotificationPermissionGranted.isGranted) {
      final showNotifications = await _prefs.getPrefs(PrefsKey.showNotifications);
      final showCheckInReminderNotification = await _prefs.getPrefs(PrefsKey.showCheckInReminderNotification);
      final showCheckOutReminderNotification = await _prefs.getPrefs(PrefsKey.showCheckOutReminderNotification);
      final checkInReminderTime = await _prefs.getPrefs(PrefsKey.checkInReminderTime);
      final checkOutReminderTime = await _prefs.getPrefs(PrefsKey.checkOutReminderTime);

      state = state.copyWith(
        showNotifications: showNotifications ?? false,
        showCheckInReminderNotification: showCheckInReminderNotification ?? false,
        showCheckOutReminderNotification: showCheckOutReminderNotification ?? false,
        checkInReminderTime: checkInReminderTime ?? '7:45',
        checkOutReminderTime: checkOutReminderTime ?? '16:45',
        checkInReminderScheduleWidgetVisible: showCheckInReminderNotification ?? false,
        checkOutReminderScheduleWidgetVisible: showCheckOutReminderNotification ?? false,
      );
    } else {
      await _prefs.savePrefs(PrefsKey.showNotifications, false);
      await _prefs.savePrefs(PrefsKey.showCheckInReminderNotification, false);
      await _prefs.savePrefs(PrefsKey.showCheckOutReminderNotification, false);
      state = state.copyWith(
        showNotifications: false,
        showCheckInReminderNotification: false,
        showCheckOutReminderNotification: false,
        checkInReminderTime: '7:45',
        checkOutReminderTime: '16:45',
        checkInReminderScheduleWidgetVisible: false,
        checkOutReminderScheduleWidgetVisible: false,
      );
    }
  }

  void setShowNotifications(bool showNotifications) async {
    final isNotificationPermissionGranted = await checkNotificationPermission();

    if (isNotificationPermissionGranted.isGranted) {
      state = state.copyWith(
        showNotifications: showNotifications,
        showCheckInReminderNotification: showNotifications ? state.showCheckInReminderNotification : false,
        showCheckOutReminderNotification: showNotifications ? state.showCheckOutReminderNotification : false,
        checkInReminderScheduleWidgetVisible: showNotifications ? state.showCheckInReminderNotification : false,
        checkOutReminderScheduleWidgetVisible: showNotifications ? state.showCheckOutReminderNotification : false,
      );
      await _prefs.savePrefs(PrefsKey.showNotifications, showNotifications);
      await _prefs.savePrefs(PrefsKey.showCheckInReminderNotification, showNotifications ? state.showCheckInReminderNotification : false);
      await _prefs.savePrefs(PrefsKey.showCheckOutReminderNotification, showNotifications ? state.showCheckOutReminderNotification : false);
    } else {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
    }

  }

  void setShowCheckInReminderNotification(bool showCheckInReminderNotification) async {
    final checkInReminderTime = await _prefs.getPrefs(PrefsKey.checkInReminderTime);
    state = state.copyWith(
        showCheckInReminderNotification: showCheckInReminderNotification,
        checkInReminderScheduleWidgetVisible: showCheckInReminderNotification,
    );
    if (checkInReminderTime == null) {
      await _prefs.savePrefs(PrefsKey.checkInReminderTime, '7:45');
      state = state.copyWith(checkInReminderTime: '7:45');
    }
    await _prefs.savePrefs(PrefsKey.showCheckInReminderNotification, showCheckInReminderNotification);
  }

  void setShowCheckOutReminderNotification(bool showCheckOutReminderNotification) async {
    final checkOutReminderTime = await _prefs.getPrefs(PrefsKey.checkOutReminderTime);
    state = state.copyWith(
        showCheckOutReminderNotification: showCheckOutReminderNotification,
        checkOutReminderScheduleWidgetVisible: showCheckOutReminderNotification,
    );
    if (checkOutReminderTime == null) {
      await _prefs.savePrefs(PrefsKey.checkOutReminderTime, '16:45');
      state = state.copyWith(checkOutReminderTime: '16:45');
    }
    await _prefs.savePrefs(PrefsKey.showCheckOutReminderNotification, showCheckOutReminderNotification);
  }

  void setCheckInReminderTime(String checkInReminderTime) async {
    state = state.copyWith(checkInReminderTime: checkInReminderTime);
    await _prefs.savePrefs(PrefsKey.checkInReminderTime, checkInReminderTime);
  }

  void setCheckOutReminderTime(String checkOutReminderTime) async {
    state = state.copyWith(checkOutReminderTime: checkOutReminderTime);
    await _prefs.savePrefs(PrefsKey.checkOutReminderTime, checkOutReminderTime);
  }

}

final notificationSettingsProvider = StateNotifierProvider.autoDispose<NotificationSettingsStateNotifier, NotificationSettingsState>((ref) => NotificationSettingsStateNotifier());