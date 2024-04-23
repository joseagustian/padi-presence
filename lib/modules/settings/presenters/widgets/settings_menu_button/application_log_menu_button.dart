import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/routes/router.dart';

class ApplicationLogMenuButton extends ConsumerWidget {
  const ApplicationLogMenuButton({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10
      ),
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
      child: InkWell(
        onTap: () {
          router.push('/application-log');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.shade400,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: const Icon(
                    Iconsax.message_programming_bold,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  Strings.applicationLog,
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
              color: Colors.blueGrey.shade700
            )
          ],
        ),
      ),
    );
  }
}
