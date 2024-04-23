import 'package:flutter/material.dart';
import 'package:padi/modules/settings/presenters/widgets/application_help/app_help_appbar.dart';
import 'package:padi/modules/settings/presenters/widgets/application_help/app_help_content.dart';

class AppHelpPage extends StatelessWidget {
  const AppHelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppHelpAppBar(),
            AppHelpContent()
          ],
        )
      ),
    );
  }
}
