import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
class DateTimeProvider {
  DateTime now() => DateTime.now();

  String getToday() {
    var formatter = DateFormat('EEEE, d MMMM y', 'id_ID');
    final now = this.now();
    return formatter.format(now);
  }

  String getTime() {
    var formatter = DateFormat('HH:mm:ss', 'id_ID');
    final now = this.now();
    return formatter.format(now);
  }

  String get2DigitsDateToday() {
    var formatter = DateFormat('dd', 'id_ID');
    final now = this.now();
    return formatter.format(now);
  }

  String getLocalTime() {
    var formatter = DateFormat('HH:mm', 'id_ID');
    final now = this.now();
    return formatter.format(now);
  }

  String getMonthAndYear() {
    var formatter = DateFormat('MMMM y', 'id_ID');
    final now = this.now();
    return formatter.format(now);
  }

  String getMonthNumber() {
    var formatter = DateFormat('MM', 'id_ID');
    final now = this.now();
    return formatter.format(now);
  }

  String getYear() {
    var formatter = DateFormat('y', 'id_ID');
    final now = this.now();
    return formatter.format(now);
  }

  String getMonthNumberAndYear() {
    var formatter = DateFormat('MM/y', 'id_ID');
    final now = this.now();
    // with format MM/yyyy

    return formatter.format(now);
  }

  String getTimestamp() {
    DateTime now = this.now();
    double timestamp = now.millisecondsSinceEpoch / 1000;
    return timestamp.toStringAsFixed(0);
  }

}

final dateTimeProvider = Provider<DateTimeProvider>((ref) {
  return DateTimeProvider();
});

final dateTodayProvider = Provider<String>((ref) {
  return ref.watch(dateTimeProvider).getToday();
});

final timeNowProvider = Provider<String>((ref) {
  return ref.watch(dateTimeProvider).getTime();
});

final twoDigitsDateTodayNumberProvider = Provider<String>((ref) {
  return ref.watch(dateTimeProvider).get2DigitsDateToday();
});

final monthNowProvider = Provider<String>((ref) {
  return ref.watch(dateTimeProvider).getMonthAndYear();
});

final monthNumberProvider = Provider<String>((ref) {
  return ref.watch(dateTimeProvider).getMonthNumber();
});

final yearNowProvider = Provider<String>((ref) {
  return ref.watch(dateTimeProvider).getYear();
});

final monthNumberAndYearProvider = Provider<String>((ref) {
  return ref.watch(dateTimeProvider).getMonthNumberAndYear();
});

final timestampProvider = Provider<String>((ref) {
  return ref.watch(dateTimeProvider).getTimestamp();
});