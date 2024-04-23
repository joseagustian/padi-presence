
import 'package:flutter/material.dart';
import 'package:padi/core/validators/validators.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/messenger_alert_dialog.dart';

validateCaptchaForm(
    TextEditingController submittedCaptcha,
    int captcha,
    BuildContext context,
    void Function() onPassed,
) {
  final submittedCaptchaValue = submittedCaptcha.text;
  final validationErrors = {
    'Captcha': Validator.validateCaptcha(submittedCaptchaValue, captcha),
  };

  if (validationErrors['Captcha'] != null) {
    bool error = false;
    showMessengerAlertDialog(
        context,
        validationErrors['Captcha']!,
        error,
        () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
  } else {
    onPassed();
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
      builder: (context) => MessengerAlertDialog(
        context: context,
        message: message,
        isSuccess: isSuccess,
        onPressed: onPressed,
      )
  );
}