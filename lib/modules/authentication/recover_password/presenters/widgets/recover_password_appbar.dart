import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/routes/router.dart';

class RecoverPasswordAppBar extends StatelessWidget {
  const RecoverPasswordAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              router.go('/login');
            },
            child: Icon(
                EvaIcons.arrow_back_outline,
                color: Colors.blueGrey.shade700,
                size: 30
            ),
          ),
          const SizedBox(height: 20),
          Text(
            Strings.recoverPasswordGreetings,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            Strings.pleaseFollowRecoverPasswordInstructions,
            style: TextStyle(
              fontSize: 16,
              color: Colors.blueGrey.shade400,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
