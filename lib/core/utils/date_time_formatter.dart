import 'package:intl/intl.dart';

String? getDayFromAttendanceTimestamp(String? time) {
  if (time == null || time.isEmpty) {
    return null; // Handle null or empty input
  }
  final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.tryParse(time) ?? 0 * 1000);
  final DateFormat formatter = DateFormat('EEEE', 'id_ID');
  return formatter.format(dateTime);
}

String? getDateFromAttendanceTimestamp(String? time) {
  if (time == null || time.isEmpty) {
    return null; // Handle null or empty input
  }
  final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.tryParse(time) ?? 0 * 1000);
  final DateFormat formatter = DateFormat('dd', 'id_ID');
  return formatter.format(dateTime);
}

String? getTimeFromAttendanceTimestamp(String? time) {
  if (time == null || time.isEmpty) {
    return '--:--';
  }
  final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.tryParse(time) ?? 0 * 1000);
  final DateFormat formatter = DateFormat('HH:mm', 'id_ID');
  return formatter.format(dateTime);
}

String getDayFromAttendanceTime(String? time) {
  if (time == null || time.isEmpty) {
    return '----';
  }

  final localTime = DateTime.parse(time);

  final DateFormat formatter = DateFormat('EEEE', 'id_ID');
  return formatter.format(localTime);
}

String getDateFromAttendanceTime(String? time) {
  if (time == null || time.isEmpty) {
    return '--';
  }

  final localTime = DateTime.parse(time);

  final DateFormat formatter = DateFormat('dd', 'id_ID');
  return formatter.format(localTime);
}

String getTimeFromAttendanceTime(String? time) {
  if (time == null || time.isEmpty) {
    return '--:--';
  }

  final DateTime localTime = DateTime.parse(time);
  final DateFormat formatter = DateFormat('HH:mm', 'id_ID');

  return formatter.format(localTime);
}

String? formatWorkingHours(String? workingHours) {
  if (workingHours == null) {
    return '--:--';
  }
  List<String> parts = workingHours.split(':');
  if (parts.isEmpty) {
    return '--:--';
  } else if (parts.length != 2) {
    return '--:--';
  }

  int hours = int.tryParse(parts[0]) ?? 0;
  int minutes = int.tryParse(parts[1]) ?? 0;

  int totalMinutes = (hours * 60) + minutes;

  int totalHours = totalMinutes ~/ 60;
  int minuteResult = totalMinutes % 60;

  String totalWorkingHours = '${totalHours.toString().padLeft(2, '0')}j ${minuteResult.toString().padLeft(2, '0')}m';

  return totalWorkingHours;
}

String? formatWorkingDateAndTime(String? time) {
  if (time == null || time.isEmpty) {
    return '-- -- --';
  }

  final DateTime localTime = DateTime.parse(time);

  final DateFormat formatter = DateFormat('d MMM y', 'id_ID');
  return formatter.format(localTime);
}

String formatSummaryWorkingHour(String workingHour) {
  List<String> parts = workingHour.split(':');
  if (parts.length != 2) {
    return '00j 00m';
  }

  int hours = int.tryParse(parts[0]) ?? 0;
  int minutes = int.tryParse(parts[1]) ?? 0;

  int totalMinutes = (hours * 60) + minutes;

  int totalHours = totalMinutes ~/ 60;
  int minuteResult = totalMinutes % 60;

  String formattedHours = totalHours > 100 ? totalHours.toString() : totalHours.toString().padLeft(2, '0');

  String workingHours = '${formattedHours.padLeft(2, '0')}j ${minuteResult.toString().padLeft(2, '0')}m';
  return workingHours;
}

String formatSummaryDays(String workingDay) {
  String formattedTotalDays = '$workingDay Hari';
  return formattedTotalDays;
}

String formatDateToIso8601WithMilliseconds(String date) {
  DateTime dateTime = DateTime.parse(date.replaceFirst(' ', 'T'));

  DateTime dateTimeWithMilliseconds = dateTime.add(const Duration(milliseconds: 842586)); // Example: Adding 123 milliseconds

  String iso8601String = dateTimeWithMilliseconds.toIso8601String();


  List<String> parts = iso8601String.split('.');
  if (parts.length == 2) {
    return '${parts[0]}.${parts[1].padRight(6, '0')}';
  } else {
    return iso8601String.padRight(23, '0');
  }
}