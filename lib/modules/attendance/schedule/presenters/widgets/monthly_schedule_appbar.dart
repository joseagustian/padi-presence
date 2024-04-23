import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/routes/router.dart';

class MonthlyScheduleAppBar extends StatelessWidget {
  const MonthlyScheduleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15.0,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    router.pop(context);
                  },
                  splashFactory: NoSplash.splashFactory,
                  child: Icon(
                      EvaIcons.arrow_back_outline,
                      color: Colors.blueGrey.shade700,
                      size: 24
                  ),
                ),
                Expanded(
                  child: Text(
                    Strings.monthlySchedule,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 24),
              ],
            ),
          ),
          Divider(
              height: 0.5,
              color: Colors.blueGrey.shade100
          )
        ],
      ),
    );
  }
}
