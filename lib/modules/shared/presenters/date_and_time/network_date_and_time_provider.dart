import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ntp/ntp.dart';

class DateAndTimeState {
  final bool isLocalTimeMatchWithServer;

  DateAndTimeState({
    required this.isLocalTimeMatchWithServer
  });

  DateAndTimeState copyWith({
    bool? isLocalTimeMatchWithServer
  }) {
    return DateAndTimeState(
      isLocalTimeMatchWithServer: isLocalTimeMatchWithServer ?? this.isLocalTimeMatchWithServer
    );
  }

}
class NetworkDateAndTimeProvider extends StateNotifier<DateAndTimeState> {

  NetworkDateAndTimeProvider() : super(DateAndTimeState(isLocalTimeMatchWithServer: false)) {
    _init();
  }


  Future<DateTime> now() async {
    return await NTP.now(
        lookUpAddress: 'time.google.com',
        timeout: const Duration(seconds: 10)
    );
  }

  void _init() async {
    checkTime();
  }

  void checkTime() async {
    final serverTime = await now();
    final localTime = DateTime.now();
    final isMatch = serverTime.difference(localTime).inSeconds.abs() <= 5;
    state = state.copyWith(isLocalTimeMatchWithServer: isMatch);
  }

}

final networkDateAndTimeProvider = StateNotifierProvider<NetworkDateAndTimeProvider, DateAndTimeState>((ref) {
  return NetworkDateAndTimeProvider();
});