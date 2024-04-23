import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateAndTimeState {
  final String timeAndDate;

  DateAndTimeState({
    required this.timeAndDate,
  });

  DateAndTimeState copyWith({
    String? timeAndDate,
  }) {
    return DateAndTimeState(
      timeAndDate: timeAndDate ?? this.timeAndDate,
    );
  }

}

class DateAndTimeNotifier extends StateNotifier<DateAndTimeState> {

  late StreamSubscription<int> timerSubscription;

  DateAndTimeNotifier() : super(DateAndTimeState(
    timeAndDate: '',
  )) {
    timerSubscription = Stream.periodic(const Duration(milliseconds: 500), (count) => count)
        .takeWhile((count) => mounted)
        .listen((count) {
      _generateTimeAndDate();
    });
    _generateTimeAndDate();
  }

  void _generateTimeAndDate() {
    final dateTime = DateTime.now().toLocal();
    final dateTimeFormat = DateFormat('EEEE, dd MMM yyyy | HH:mm:ss', 'id_ID');
    final newTimeAndDate = dateTimeFormat.format(dateTime);
    state = DateAndTimeState(timeAndDate: newTimeAndDate);
  }

}

final streamDateAndTimeProvider = StateNotifierProvider<DateAndTimeNotifier, DateAndTimeState>((ref) {
  return DateAndTimeNotifier();
});