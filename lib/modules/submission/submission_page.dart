import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/submission/presenters/widgets/submission_appbar.dart';

import 'presenters/widgets/create_submission_dialog/create_submission_alert_dialog.dart';

class SubmissionPage extends StatelessWidget {
  const SubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
          child: Column(
            children: [
              SubmissionAppBar()
            ],
          ),
      ),
      floatingActionButton:
      SizedBox(
        width: 80,
        height: 40,
        child: FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            foregroundColor: Colors.white70,
            backgroundColor: Colors.blueGrey.shade900,
            splashColor: Colors.blueGrey.shade100,
            onPressed: () {
              showCreateSubmissionAlertDialog(context);
            },
            icon: const Icon(
                Icons.add,
                size: 20,
            ),
            label: const Text(
                Strings.create,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2
                )
            ),
          ),
      ),

    );
  }
}
