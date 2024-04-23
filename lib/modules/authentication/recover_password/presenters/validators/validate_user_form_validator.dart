import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/validators/validators.dart';
import 'package:padi/modules/authentication/recover_password/infra/models/validate_user_model.dart';
import 'package:padi/modules/authentication/recover_password/validate_user_provider.dart';
import 'package:padi/modules/shared/presenters/captcha_dialog/captcha_alert_dialog.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/loading_alert_dialog.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/messenger_alert_dialog.dart';

void validateUserForm(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController securityQuestionController,
    TextEditingController securityAnswerController,
    ExpandableController securityQuestionExpandableController,
    ExpandableController newPasswordExpandableController,
    ValidateUserProvider validateUserProvider,
    void Function() onValidated
) {
  final email = emailController.text;
  final securityQuestion = securityQuestionController.text;
  final securityQuestionAnswer = securityAnswerController.text;
  final allEmpty = email.isEmpty && securityQuestion.isEmpty && securityQuestionAnswer.isEmpty;

  final validationErrors = {
    'Email': Validator.validateEmail(email),
    'Security Question': Validator.validateSecurityQuestionSelection(securityQuestion),
    'Security Question Answer': Validator.validateSecurityQuestionAnswer(securityQuestionAnswer),
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

  void onPassed() {
    Navigator.of(context, rootNavigator: true).pop();
    ValidateUserBodyRequest validateUserBodyRequest = ValidateUserBodyRequest(
        email: email,
        question: securityQuestion,
        answer: securityQuestionAnswer
    );

    showLoadingAlertDialog(
        context,
        Strings.validatingAccount
    );

    validateUserProvider.validateUser(validateUserBodyRequest).then((value) {
      Navigator.of(context, rootNavigator: true).pop();
      bool success = true;
      showMessengerAlertDialog(context,
          Strings.accountValidated,
          success,
              () {
            onValidated();
            securityQuestionExpandableController.expanded = false;
            Navigator.of(context, rootNavigator: true).pop();
            newPasswordExpandableController.expanded = true;
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

  showCaptchaAlertDialog(
      context,
          () {
        onPassed();
      }
  );

}