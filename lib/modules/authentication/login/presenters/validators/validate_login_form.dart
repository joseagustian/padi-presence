import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/data/database/models/padi_user_model.dart';
import 'package:padi/core/data/database/repositories/padi_user_table_repository.dart';
import 'package:padi/core/routes/router.dart';
import 'package:padi/core/validators/validators.dart';
import 'package:padi/modules/authentication/login/login_provider.dart';
import 'package:padi/modules/shared/presenters/captcha_dialog/captcha_alert_dialog.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/loading_alert_dialog.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/messenger_alert_dialog.dart';

import '../../infra/models/login_model.dart';

void validateLoginForm(
    GlobalKey<FormState> formKey,
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    LoginProvider loginProvider,
    ) {

  PadiUserAccountTableRepository padiUserAccountTableRepository = PadiUserAccountTableRepository();

  final email = emailController.text;
  final password = passwordController.text;
  final emailError = Validator.validateEmail(email);
  final passwordError = Validator.validatePassword(password);
  final allEmpty = email.isEmpty && password.isEmpty;

  if (formKey.currentState!.validate()) {
    void onPassed() {
      Navigator.of(context, rootNavigator: true).pop();
      showLoadingAlertDialog(
          context,
          Strings.loggingIn
      );
      loginProvider.login(
          LoginBodyRequest(
              email: email,
              password: password
          )
      ).then((value) {

        PadiUserAccountModel padiUserAccountModel = PadiUserAccountModel(
          userId: value.data!.id,
          userEmail: value.data!.email,
          userAccountName: value.data!.name,
          userEmployeeId: value.data!.nip,
          userDateOfBirth: value.data!.dateOfBirth,
          userAddress: value.data!.address,
          userReligion: value.data!.religion,
          userJobPosition: value.data!.positionName,
          userJobDivision: value.data!.divisionName,
          userAccessToken: value.token,
          userOfficeLat: value.data!.officeLat.toString(),
          userOfficeLong: value.data!.officeLong.toString(),
          onProgressAttendanceId: value.data!.onProgressAttendanceId,
        );

        Navigator.of(context, rootNavigator: true).pop();
        padiUserAccountTableRepository.insertPadiUserAccount(padiUserAccountModel);


        router.go('/dashboard');

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

    showCaptchaAlertDialog(
        context,
            () {
          onPassed();
        }
    );

  } else if (allEmpty) {
    bool error = false;
    showMessengerAlertDialog(
        context,
        Strings.makeSureAllFieldsFilled,
        error,
        () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
  } else if (emailError != null) {
    bool error = false;
    showMessengerAlertDialog(
        context,
        emailError,
        error,
        () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
  } else if (passwordError != null) {
    bool error = false;
    showMessengerAlertDialog(
        context,
        passwordError,
        error,
        () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
  }
}