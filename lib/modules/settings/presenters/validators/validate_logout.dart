
import 'package:flutter/cupertino.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/data/database/repositories/padi_user_table_repository.dart';
import 'package:padi/core/utils/shared_preferences.dart';
import 'package:padi/modules/navigation_provider.dart';
import 'package:padi/modules/settings/logout_provider.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/loading_alert_dialog.dart';
import 'package:padi/modules/shared/presenters/alert_dialog/messenger_alert_dialog.dart';
import 'package:restart/restart.dart';

void validateLogout(
    BuildContext context,
    LogoutProvider logoutProvider,
    NavigationState navigationState
) {
  final prefs = SharedPreferencesUtils();
  final padiUserAccountTableRepository = PadiUserAccountTableRepository();


  Navigator.of(context, rootNavigator: true).pop();

  showLoadingAlertDialog(
      context,
      Strings.loggingOut
  );

  logoutProvider.logout().then((value) async {

    Navigator.of(context, rootNavigator: true).pop();

    await prefs.clearPrefs();
    await padiUserAccountTableRepository.deletePadiUserAccount();

    await Future.delayed(const Duration(milliseconds: 100), () {
      restartApp();
    });


  }).catchError((e) {
    bool error = false;
    Navigator.of(context, rootNavigator: true).pop();
    showMessengerAlertDialog(
        context,
        Strings.somethingWentWrong,
        error,
        () {
          Navigator.of(context, rootNavigator: true).pop();
        }
    );
  });
}

void restartApp() {
  restart();
}