import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/modules/settings/presenters/widgets/notification_settings/check_in_notifications.dart';
import 'package:padi/modules/settings/presenters/widgets/notification_settings/check_out_notifications.dart';
import 'package:padi/modules/settings/presenters/widgets/notification_settings/general_notification.dart';

import 'notification_settings_state_provider.dart';

class NotificationSettingsMenu extends ConsumerWidget {
  const NotificationSettingsMenu({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(notificationSettingsProvider);
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            GeneralNotificationMenu(
              isNotificationEnabled: state.showNotifications,
              onNotificationChanged: (value) {
                ref.read(notificationSettingsProvider.notifier).setShowNotifications(
                    value
                );
              },
            ),
            CheckInNotificationMenu(
              isNotificationEnabled: state.showNotifications,
              widgetVisible: state.checkInReminderScheduleWidgetVisible,
              isCheckInNotificationEnabled: state.showCheckInReminderNotification,
              checkInNotificationSchedule: state.checkInReminderTime,
              onCheckInNotificationChanged: (value) {
                  ref.read(notificationSettingsProvider.notifier).setShowCheckInReminderNotification(
                      value
                  );
              },
              onCheckInNotificationScheduleChanged: (value) {
                ref.read(notificationSettingsProvider.notifier).setCheckInReminderTime(
                    value
                );
              },
            ),
            CheckOutNotificationsMenu(
              isNotificationEnabled: state.showNotifications,
              widgetVisible: state.checkOutReminderScheduleWidgetVisible,
              isCheckOutNotificationEnabled: state.showCheckOutReminderNotification,
              checkOutNotificationSchedule: state.checkOutReminderTime,
              onCheckOutNotificationChanged: (value) {
                ref.read(notificationSettingsProvider.notifier).setShowCheckOutReminderNotification(
                    value
                );
              },
              onCheckOutNotificationScheduleChanged: (value) {
                ref.read(notificationSettingsProvider.notifier).setCheckOutReminderTime(
                    value
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
