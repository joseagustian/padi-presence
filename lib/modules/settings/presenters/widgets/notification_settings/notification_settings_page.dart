import 'package:flutter/material.dart';

import 'notification_settings_appbar.dart';
import 'notification_settings_menu.dart';

class NotificationSettingsPage extends StatelessWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            NotificationSettingsAppBar(),
            NotificationSettingsMenu(),
          ],
        ),
      ),
    );
  }
}
