import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/strings.dart';

class SubmissionAppBar extends StatelessWidget {
  const SubmissionAppBar({super.key});

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

                },
                splashFactory: NoSplash.splashFactory,
                child: Icon(
                    Bootstrap.archive,
                    color: Colors.blueGrey.shade700,
                    size: 22
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
