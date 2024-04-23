
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:padi/core/constants/constant.dart';

import 'shared_preferences.dart';

enum LogType {
  info,
  warning,
  error,
}

class AppLogger {
  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  String generateLogId() {
    const String chars = CHAR;
    final random = Random();

    List<String> chunks = [];

    for (var i = 0; i < 5; i++) {
      String chunk = String.fromCharCodes(
        List.generate(
          4,
              (_) => chars.codeUnitAt(random.nextInt(chars.length)),
        ),
      );
      chunks.add(chunk);
    }

    return chunks.join('-');
  }

  void recordLog(String message, LogType type) async {
    DateTime now = DateTime.now();
    String logRecordTime = DateFormat('yyyy-MM-ddTHH:mm:ss').format(now);
    String log;
    String logId = generateLogId();

    switch (type) {
      case LogType.info:
        log = '{"logId": "$logId", "time": "$logRecordTime", "log": "$message", "type": "info"}';
        break;
      case LogType.warning:
        log = '{"logId": "$logId", "time": "$logRecordTime", "log": "$message", "type": "warning"}';
        break;
      case LogType.error:
        log = '{"logId": "$logId", "time": "$logRecordTime", "log": "$message", "type": "error"}';
        break;
    }

    final existingLogs = await prefs.getPrefsList(PrefsKey.applicationLogs);
    final newLogs = [log, ...existingLogs];
    await prefs.savePrefs(PrefsKey.applicationLogs, newLogs);

  }

  void clearLogs() async {
    await prefs.removePrefs(PrefsKey.applicationLogs);
  }

}

class LoggerMessage {

  LoggerMessage._();

  static const String lastLogin = 'Melakukan Log Masuk';
  static const String fetchWorkingTimeSummary = 'Mengambil Data Ringkasan Aktivitas Bulanan';
  static const String refreshWorkingTimeSummary = 'Memperbarui Data Ringkasan Aktivitas Bulanan';
  static const String failedToFetchWorkingTimeSummary = 'Gagal Mengambil Data Ringkasan Aktivitas Bulanan';
  static const String locationServiceDisabled = 'Layanan Lokasi Tidak Aktif';
  static const String fetchAttendanceHistoryList = 'Mengambil Data Daftar Riwayat Kehadiran';
  static const String refreshAttendanceHistoryList = 'Memperbarui Daftar Riwayat Kehadiran';
  static const String failedToFetchAttendanceHistoryList = 'Gagal Mengambil Data Daftar Riwayat Kehadiran';
  static const String fetchAttendanceHistoryDetail = 'Mengambil Data Detail Riwayat Kehadiran';
  static const String refreshAttendanceHistoryDetail = 'Memperbarui Data Detail Riwayat Kehadiran';
  static const String failedToFetchAttendanceHistoryDetail = 'Gagal Mengambil Data Detail Riwayat Kehadiran';
  static const String sendCheckInRequest = 'Mengirim Data Kehadiran Masuk';
  static const String failedToSendCheckInRequest = 'Gagal Mengirim Data Kehadiran Masuk';
  static const String sendCheckOutRequest = 'Mengirim Data Kepulangan';
  static const String failedToSendCheckOutRequest = 'Gagal Mengirim Data Kepulangan';
  static const String sendAttendanceCorrectionRequest = 'Mengirim Data Koreksi Kehadiran';
  static const String failedToSendAttendanceCorrectionRequest = 'Gagal Mengirim Data Koreksi Kehadiran';

}