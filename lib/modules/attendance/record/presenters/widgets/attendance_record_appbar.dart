import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/routes/router.dart';

class AttendanceRecordAppBar extends StatelessWidget {
  const AttendanceRecordAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                  router.push('/monthly-schedule');
                },
                splashFactory: NoSplash.splashFactory,
                child: Icon(
                    Icons.calendar_month_outlined,
                    color: Colors.blueGrey.shade700,
                    size: 24
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 0.5,
          color: Colors.blueGrey.shade100
        )
      ],
    );
  }
}
