import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/messenger_alert_dialog_button.dart';

class MessengerAlertDialog extends StatelessWidget {
  const MessengerAlertDialog({
    super.key,
    required this.context,
    required this.message,
    required this.isSuccess,
    required this.onPressed,
  });
  final BuildContext context;
  final String message;
  final bool isSuccess;
  final  void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20.0),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.3,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              isSuccess ? Icons.check_circle : Icons.error,
              color: isSuccess ? Colors.green : Colors.red,
              size: 80,
            ),
            const SizedBox(height: 5),
            Text(
              isSuccess ? Strings.success : Strings.failed,
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                color: isSuccess ? Colors.blueGrey.shade900 : Colors.red.shade900,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Lato',
                color: Colors.blueGrey.shade400,
              ),
            ),
            const SizedBox(height: 10),
            MessengerAlertDialogButton(
                buttonText: isSuccess ? Strings.doContinue : Strings.tryAgain,
                isSuccess: isSuccess,
                onPressed: onPressed
            )
          ],
        ),
      ),
    );
  }
}

void showMessengerAlertDialog(
    BuildContext context,
    String message,
    bool isSuccess,
    void Function() onPressed
    ) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => MessengerAlertDialog(
        context: context,
        message: message,
        isSuccess: isSuccess,
        onPressed: onPressed,
      )
  );
}
