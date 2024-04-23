import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/constant.dart';

class CaptchaState {
  final int captcha;
  final double remainingTime;

  CaptchaState(this.captcha, this.remainingTime);

  CaptchaState copyWith({int? captcha, double? progress}) {
    return CaptchaState(
      captcha ?? this.captcha,
      progress ?? remainingTime,
    );
  }
}

class CaptchaNotifier extends StateNotifier<CaptchaState> {
  late StreamSubscription<int> timerSubscription;
  late StreamSubscription<int> _timer;

  CaptchaNotifier() : super(CaptchaState(0, 0.0)) {
    timerSubscription = Stream.periodic(const Duration(seconds: 15), (count) => count)
        .takeWhile((count) => mounted)
        .listen((count) {
      _generateCaptcha();
      _startTimer();
    });
    _generateCaptcha();
    _startTimer();
  }

  int step = 0;

  int generateCaptcha() {
    final random = Random();
    return random.nextInt(9000) + 1000;
  }

  void _generateCaptcha() {
    final newCaptcha = generateCaptcha();
    state = CaptchaState(newCaptcha, 0.0);
  }

  void _startTimer() {
    const totalTime = CAPTCHA_TIMER;
    const updateInterval = CAPTCHA_UPDATE_INTERVAL;
    const steps = totalTime ~/ updateInterval;

    timerSubscription.cancel();

    _timer = Stream.periodic(const Duration(milliseconds: updateInterval), (count) => count)
        .takeWhile((count) => step < steps)
        .listen((count) {
      step++;
      final progress = step / steps;
      state = state.copyWith(progress: progress);

      if (step >= steps) {
        timerSubscription.cancel();
        state = state.copyWith(progress: 1.0);
        refreshCaptcha();
      }
    });
  }

  void refreshCaptcha() {
    step = 0;
    _generateCaptcha();
  }

  @override
  void dispose() {
    timerSubscription.cancel();
    _timer.cancel();
    super.dispose();
  }

}

final captchaProvider = StateNotifierProvider.autoDispose<CaptchaNotifier, CaptchaState>((ref) {
  return CaptchaNotifier();
});