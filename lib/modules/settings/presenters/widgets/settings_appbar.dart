import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';

class SettingsAppBar extends StatelessWidget {
  const SettingsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(Strings.pathLogoPadiPlain),
            height: 28,
          ),
        ],
      ),
    );
  }
}
