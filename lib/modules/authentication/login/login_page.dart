import 'package:flutter/material.dart';

import 'presenters/widgets/login_form.dart';
import 'presenters/widgets/welcoming_message.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WelcomingMessage(),
                LoginForm()
              ],
            ),
          )
        )
      )
    );
  }
}
