import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/routes/router.dart';
import 'package:padi/core/validators/validators.dart';
import 'package:padi/modules/authentication/recover_password/infra/models/recover_password_model.dart';
import 'package:padi/modules/authentication/recover_password/recover_password_provider.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/loading_alert_dialog.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/messenger_alert_dialog.dart';

void validateRecoverPasswordForm(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController newPasswordController,
    TextEditingController confirmationPasswordController,
    RecoverPasswordProvider recoverPasswordProvider,
) {
  final email = emailController.text;
  final newPassword = newPasswordController.text;
  final confirmationPassword = confirmationPasswordController.text;
  final allEmpty = email.isEmpty && newPassword.isEmpty && confirmationPassword.isEmpty;

  final validationErrors = {
    'Email': Validator.validateEmail(email),
    'New Password': Validator.validateNewPassword(newPassword),
    'Confirmation Password': Validator.validateConfirmationPassword(confirmationPassword, newPassword),
  };

  if (allEmpty) {
    bool error = false;
    showMessengerAlertDialog(
        context,
        Strings.makeSureAllFieldsFilled,
        error,
            () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
    return;
  }

  for (var field in validationErrors.entries) {
    if (field.value != null) {
      bool error = false;
      showMessengerAlertDialog(
          context,
          field.value!,
          error,
              () {
            Navigator.of(context, rootNavigator: true).pop();
          }
      );
      return;
    }
  }

  RecoverPasswordBodyRequest recoverPasswordBodyRequest = RecoverPasswordBodyRequest(
      email: email,
      newPassword: newPassword,
  );

  showLoadingAlertDialog(
      context,
      Strings.recoveringPassword
  );

  recoverPasswordProvider.recoverPassword(recoverPasswordBodyRequest).then((value) {
    Navigator.of(context, rootNavigator: true).pop();
    bool success = true;
    showMessengerAlertDialog(context,
        Strings.recoverPasswordSuccess,
        success,
            () {
          Navigator.of(context, rootNavigator: true).pop();
          router.go('/login');
        }
    );
  }).catchError((e) {
    Navigator.of(context, rootNavigator: true).pop();
    bool error = false;
    showMessengerAlertDialog(context,
        e.toString().contains('ClientException') ? Strings.noInternetConnection :  e.toString().replaceAll('Exception:', ''),
        error,
            () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
  });
}