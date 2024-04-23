import 'package:flutter/material.dart';

import 'presenters/widgets/recover_password_appbar.dart';
import 'presenters/widgets/recover_password_form.dart';

class RecoverPasswordPage extends StatelessWidget {
  const RecoverPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RecoverPasswordAppBar(),
              RecoverPasswordForm()
            ],
          ),
        ),
      ),
    );
  }
}
