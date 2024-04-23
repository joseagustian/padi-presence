import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/navigation_provider.dart';
import 'package:padi/modules/settings/logout_provider.dart';
import 'package:padi/modules/settings/presenters/validators/validate_logout.dart';

import 'confirm_logout_dialog.dart';

class LogoutMenuButton extends ConsumerWidget {
  const LogoutMenuButton({super.key});

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
          showConfirmLogoutDialog(
              context,
              () {
                validateLogout(
                    context,
                    ref.read(logoutProvider),
                    ref.read(navigationProvider.notifier)
                );
              }
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.redAccent.shade400,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: const Icon(
                    BoxIcons.bx_exit,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  Strings.logOut,
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
    );
  }
}
