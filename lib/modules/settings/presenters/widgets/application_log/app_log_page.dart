import 'package:flutter/material.dart';
import 'package:padi/modules/settings/presenters/widgets/application_log/app_log_appbar.dart';

import 'app_log_list.dart';

class AppLogPage extends StatelessWidget {
  const AppLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppLogAppBar(),
            AppLogList(),
          ],
        )
      ),
    );
  }
}
