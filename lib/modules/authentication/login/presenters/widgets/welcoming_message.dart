import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';

class WelcomingMessage extends StatelessWidget {
  const WelcomingMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: 20,
          bottom: 50
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Image(
            image: const AssetImage(Strings.pathLogoPadi),
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Text(
            Strings.welcome,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            Strings.pleaseLogin,
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
