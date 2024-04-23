import 'package:flutter/material.dart';
import 'package:padi/modules/dashboard/presenters/widgets/notifications/notifications_appbar.dart';

import 'notifications_list.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            NotificationsAppBar(),
            NotificationsList(),
          ],
        )
      ),
    );
  }
}
