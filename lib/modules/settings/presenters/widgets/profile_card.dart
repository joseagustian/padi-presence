import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/data/database/providers/padi_user_table_provider.dart';
import 'package:padi/core/routes/router.dart';

import 'employee_digital_id/employee_digital_id_dialog.dart';

class ProfileCard extends ConsumerWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(padiUserDataProvider);
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
            Padding(
              padding: const EdgeInsets.only(
                  top: 15.0,
                  left: 15.0,
                  right: 15.0,
                  bottom: 15.0
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.blueGrey.shade400,
                          shape: BoxShape.circle
                      ),
                      child: Icon(
                        Icons.person,
                        size: MediaQuery.of(context).size.height * 0.05,
                        color: Colors.blueGrey.shade200,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.userAccountName,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade900,
                                overflow: TextOverflow.ellipsis
                            ),
                          ),
                          Text(
                            state.userJobPosition,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        showEmployeeDigitalIdDialog(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            shape: BoxShape.circle
                        ),
                        child: Icon(
                          Icons.qr_code_2,
                          size: 24,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                    ),
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
                router.push('/profile-settings');
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
                              color: Colors.blue.shade700,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: const Icon(
                            EvaIcons.edit,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          Strings.updateProfile,
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
            )
          ],
        )
    );
  }
}
