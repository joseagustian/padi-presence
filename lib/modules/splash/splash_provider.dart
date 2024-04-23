import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/data/database/db_helper.dart';
import 'package:padi/core/data/database/repositories/padi_user_table_repository.dart';
import 'package:padi/core/routes/router.dart';
import 'package:padi/core/utils/app_notifications.dart';
import 'package:padi/core/utils/shared_preferences.dart';
class SplashProvider {

  final DatabaseHelper _helper = DatabaseHelper();

  final PadiUserAccountTableRepository _padiUserAccountTableRepository = PadiUserAccountTableRepository();

  Future<bool> isUserLoggedIn() async {
    await _helper.database;

    final isDbCreated = await _helper.isDbCreated();

    if (isDbCreated) {
      final user = await _padiUserAccountTableRepository.getPadiUserAccount();
      return user != null;
    } else {
      return false;
    }

  }

}

class SplashStateProvider {
  final bool isUserLoggedIn;

  SplashStateProvider({
    required this.isUserLoggedIn,
  });

  SplashStateProvider copyWith({
    bool? isUserLoggedIn,
  }) {
    return SplashStateProvider(
      isUserLoggedIn: isUserLoggedIn ?? this.isUserLoggedIn,
    );
  }

}

class SplashNotifier extends StateNotifier<SplashStateProvider> {

  final SplashProvider splashProvider = SplashProvider();

  SplashNotifier() : super(SplashStateProvider(
    isUserLoggedIn: false,

  )) {
    checkUserLoggedIn();
  }

  void checkUserLoggedIn() async {
    final prefs = SharedPreferencesUtils();

    AppNotifications.onClickNotification.stream.first.then((payload) async {
      if (payload == NotificationsData.checkInReminderPayload) {
        await prefs.savePrefs(PrefsKey.isCheckInReminderShown, true);
      } else if (payload == NotificationsData.checkOutReminderPayload) {
        await prefs.savePrefs(PrefsKey.isCheckOutReminderShown, true);
      }
    });

    final isUserLoggedIn = await splashProvider.isUserLoggedIn();
    state = state.copyWith(
      isUserLoggedIn: isUserLoggedIn,
    );

    final isCheckInReminderShown = await prefs.getPrefs(PrefsKey.isCheckInReminderShown) ?? false;
    final isCheckOutReminderShown = await prefs.getPrefs(PrefsKey.isCheckOutReminderShown) ?? false;

    if (isUserLoggedIn) {
      if (isCheckInReminderShown) {
        directToAttendanceRecordPage();
        await prefs.savePrefs(PrefsKey.isCheckInReminderShown, false);
      } else if (isCheckOutReminderShown) {
        directToAttendanceRecordPage();
        await prefs.savePrefs(PrefsKey.isCheckOutReminderShown, false);
      } else {
        directToHomePage();
      }
    } else {
      directToLoginPage();
    }

  }

  void directToLoginPage() {
    Future.delayed(const Duration(seconds: 1), () {
      router.go('/login');
    });
  }

  void directToHomePage() {
    Future.delayed(const Duration(seconds: 1), () {
      router.go('/dashboard');
    });
  }

  void directToAttendanceRecordPage() {
    Future.delayed(const Duration(seconds: 1), () {
      router.go('/attendance-record');
    });
  }


}

final splashNotifierProvider = StateNotifierProvider.autoDispose<SplashNotifier, SplashStateProvider>((ref) {
  return SplashNotifier();
});