
import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/routes/router.dart';
import 'package:padi/core/validators/validators.dart';
import 'package:padi/modules/authentication/register/infra/models/register_model.dart';
import 'package:padi/modules/authentication/register/register_provider.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/loading_alert_dialog.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/messenger_alert_dialog.dart';

void validateRegisterForm(
    BuildContext context,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController securityQuestionController,
    TextEditingController securityAnswerController,
    TextEditingController birthDateController,
    TextEditingController officeLocationController,
    TextEditingController divisionController,
    TextEditingController positionController,
    TextEditingController passwordController,
    TextEditingController confirmationPasswordController,
    RegisterProvider registerProvider
) {

  final fullName = nameController.text;
  final email = emailController.text;
  final securityQuestion = securityQuestionController.text;
  final securityQuestionAnswer = securityAnswerController.text;
  final dateOfBirth = birthDateController.text;
  final officeLocation = officeLocationController.text;
  final division = divisionController.text;
  final jobPosition = positionController.text;
  final password = passwordController.text;
  final confirmationPassword = confirmationPasswordController.text;
  final allEmpty = fullName.isEmpty && email.isEmpty && securityQuestion.isEmpty && securityQuestionAnswer.isEmpty && dateOfBirth.isEmpty && division.isEmpty && jobPosition.isEmpty && password.isEmpty && confirmationPassword.isEmpty;

  final validationErrors = {
    'Full Name': Validator.validateFullName(fullName),
    'Email': Validator.validateEmail(email),
    'Security Question': Validator.validateSecurityQuestionSelection(securityQuestion),
    'Security Question Answer': Validator.validateSecurityQuestionAnswer(securityQuestionAnswer),
    'Date of Birth': Validator.validateBirthDateSelection(dateOfBirth),
    'Office Location': Validator.validateOfficeLocationSelection(officeLocation),
    'Division': Validator.validateDivisionSelection(division),
    'Job Position': Validator.validatePositionSelection(jobPosition),
    'Password': Validator.validateNewPassword(password),
    'Confirmation Password': Validator.validateConfirmationPassword(confirmationPassword, password),
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

  RegisterBodyRequest registerBodyRequest = RegisterBodyRequest(
    fullName: fullName,
    email: email,
    securityQuestion: securityQuestion,
    securityQuestionAnswer: securityQuestionAnswer,
    dateOfBirth: dateOfBirth,
    locationId: officeLocation,
    jobPosition: jobPosition,
    password: password,
  );

  showLoadingAlertDialog(
      context,
      Strings.registering
  );

  registerProvider.register(registerBodyRequest).then((value) {
    Navigator.of(context).pop();
    bool success = true;
    showMessengerAlertDialog(context,
        value.message,
        success,
        () {
          Navigator.of(context, rootNavigator: true).pop();
          router.go('/login');
        }
    );
  }).catchError((e) {
    Navigator.of(context).pop();
    bool error = false;
    showMessengerAlertDialog(
        context,
        e.toString().contains('ClientException') ? Strings.noInternetConnection :  e.toString().replaceAll('Exception:', ''),
        error,
        () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
  });

}