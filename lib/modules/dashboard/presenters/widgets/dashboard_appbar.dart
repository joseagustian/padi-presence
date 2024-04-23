import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/routes/router.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage(Strings.pathLogoPadiPlain),
            height: 28,
          ),
          InkWell(
            onTap: () {
              router.push('/notifications');
            },
            splashFactory: NoSplash.splashFactory,
            child: Icon(
                EvaIcons.bell_outline,
                color: Colors.blueGrey.shade700,
                size: 24
            ),
          ),
        ],
      ),
    );
  }
}
