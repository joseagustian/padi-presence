import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';

class AppInfoContent extends StatelessWidget {
  const AppInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: const AssetImage(Strings.pathLogoPadi),
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.height * 0.10,
          ),
          const SizedBox(height: 20),
          Text(
              Strings.appName,
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey.shade800
              ),
          ),
          Text(
            Strings.appVersion,
            style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey.shade800
            ),
          ),
          const SizedBox(height: 20),
          Text(
              Strings.appDevelopedFor,
            style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey.shade800
            ),
          ),
          Text(
              Strings.companyName,
            style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey.shade800
            ),
          ),
        ]
      ),
    );
  }
}
