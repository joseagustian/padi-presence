import 'package:flutter/material.dart';
import 'package:padi/modules/settings/presenters/widgets/settings_menu_button/about_and_support_menu_button.dart';
import 'package:padi/modules/settings/presenters/widgets/settings_menu_button/application_log_menu_button.dart';
import 'package:padi/modules/settings/presenters/widgets/settings_menu_button/logout_menu_button.dart';
import 'package:padi/modules/settings/presenters/widgets/profile_card.dart';

import 'presenters/widgets/settings_menu_button/notification_menu_button.dart';
import 'presenters/widgets/settings_appbar.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SettingsAppBar(),
            ProfileCard(),
            NotificationMenuButton(),
            ApplicationLogMenuButton(),
            AboutAndSupportMenuButton(),
            LogoutMenuButton()
          ]
        )
      ),
    );
  }
}
