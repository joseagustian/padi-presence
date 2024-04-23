
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/utils/shared_preferences.dart';

import 'attendance_record_card_button.dart';

class AttendanceRecordCardState {

  final AttendanceRecordCardButtonType type;

  const AttendanceRecordCardState({
    required this.type,
  });

  AttendanceRecordCardState copyWith({
    AttendanceRecordCardButtonType? type,
  }) {
    return AttendanceRecordCardState(
      type: type ?? this.type,
    );
  }

}

class AttendanceRecordCardNotifier extends StateNotifier<AttendanceRecordCardState> {
  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  AttendanceRecordCardNotifier() : super(
      const AttendanceRecordCardState(type: AttendanceRecordCardButtonType.checkIn)
  ) {
    _initializeState();
  }

  void _resetState() async {

    final lastAttendanceTime = await prefs.getPrefs(PrefsKey.lastAttendanceTime);

    final currentDate = DateTime.now();

    if (lastAttendanceTime != null) {

      final lastAttendanceDate = DateTime.parse(lastAttendanceTime);

      if (currentDate.day == lastAttendanceDate.day + 1) {
        await prefs.savePrefs(PrefsKey.isCheckedIn, false);
        await prefs.savePrefs(PrefsKey.isCheckedOut, false);
        await prefs.savePrefs(PrefsKey.lastAttendanceTime, '');
      }

    }

  }

  void _initializeState() async {

    _resetState();

    final isCheckedIn = await prefs.getPrefs(PrefsKey.isCheckedIn);
    final isCheckedOut = await prefs.getPrefs(PrefsKey.isCheckedOut);

    if (isCheckedIn == null || isCheckedIn == false) {
      state = state.copyWith(type: AttendanceRecordCardButtonType.checkIn);
    } else if (isCheckedIn == true) {
      state = state.copyWith(type: AttendanceRecordCardButtonType.checkOut);
    }

    if (isCheckedOut == true) {
      state = state.copyWith(type: AttendanceRecordCardButtonType.todayFinished);
    }

  }

  void _updateAttendanceStatus(bool isCheckedIn) async {

    await prefs.savePrefs(PrefsKey.isCheckedIn, isCheckedIn);
    final attendanceTime = DateTime.now();
    final formattedTime = attendanceTime.toIso8601String();

    if (isCheckedIn) {
      state = state.copyWith(type: AttendanceRecordCardButtonType.checkOut);
    } else {
      await prefs.savePrefs(PrefsKey.recentAttendanceId, null);
      await prefs.savePrefs(PrefsKey.lastAttendanceTime, formattedTime);
      await prefs.savePrefs(PrefsKey.isCheckedOut, true);
      state = state.copyWith(type: AttendanceRecordCardButtonType.todayFinished);
    }

  }

  void setAttendanceButtonState() async {

    final isCheckedIn = await prefs.getPrefs(PrefsKey.isCheckedIn);

    if (isCheckedIn == null || isCheckedIn == false) {
      _updateAttendanceStatus(true);
    } else {
      _updateAttendanceStatus(false);
    }

  }

}

final recordCardStateProvider = StateNotifierProvider<AttendanceRecordCardNotifier, AttendanceRecordCardState>((ref) => AttendanceRecordCardNotifier());