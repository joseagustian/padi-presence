import 'package:flutter/material.dart';
import 'package:padi/modules/settings/presenters/widgets/application_info/app_info_appbar.dart';
import 'package:padi/modules/settings/presenters/widgets/application_info/app_info_content.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppInfoAppBar(),
            AppInfoContent()
          ],
        )
      ),
    );
  }
}
