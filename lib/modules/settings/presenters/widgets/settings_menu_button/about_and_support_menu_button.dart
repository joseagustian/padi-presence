import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/routes/router.dart';

class AboutAndSupportMenuButton extends StatelessWidget {
  const AboutAndSupportMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 2,
              offset: const Offset(0, 1),
            )
          ]
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              router.push('/app-info');
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 15.0,
                  right: 15.0,
                  bottom: 10.0
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.lightBlueAccent.shade700,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Icon(
                          Bootstrap.info_lg,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        Strings.about,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey.shade700,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    EvaIcons.arrow_ios_forward_outline,
                    size: 18,
                    color: Colors.blueGrey.shade700,
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.5,
            color: Colors.blueGrey.shade100,
          ),
          InkWell(
            onTap: () {
              router.push('/app-help');
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 15.0,
                  right: 15.0,
                  bottom: 10.0
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.green.shade500,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Icon(
                          Iconsax.message_question_bold,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        Strings.support,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey.shade700,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    EvaIcons.arrow_ios_forward_outline,
                    size: 18,
                    color: Colors.blueGrey.shade700,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
