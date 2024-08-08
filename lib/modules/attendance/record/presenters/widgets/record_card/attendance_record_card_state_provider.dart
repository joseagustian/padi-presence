
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
      const AttendanceRecordCardState(type: AttendanceRecordCardButtonType.none)
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
        await prefs.savePrefs(PrefsKey.attendanceCheckInTime, '');
        await prefs.savePrefs(PrefsKey.attendanceCheckOutTime, '');
        await prefs.savePrefs(PrefsKey.attendanceWorkingHours, '');
      }

    }

  }

  void _initializeState() async {
    _resetState();

    final isCheckedIn = await prefs.getPrefs(PrefsKey.isCheckedIn);
    final isCheckedOut = await prefs.getPrefs(PrefsKey.isCheckedOut);
    final isTodayFinished = await prefs.getPrefs(PrefsKey.isTodayFinished);

    if (isTodayFinished != null && isTodayFinished) {
      state = state.copyWith(type: AttendanceRecordCardButtonType.todayFinished);
    } else if (isCheckedIn != null && isCheckedIn && (isCheckedOut == null || isCheckedOut == false)) {
      state = state.copyWith(type: AttendanceRecordCardButtonType.checkOut);
    } else if (isCheckedIn == null || isCheckedIn == false) {
      state = state.copyWith(type: AttendanceRecordCardButtonType.checkIn);
    } else {
      state = state.copyWith(type: AttendanceRecordCardButtonType.none);
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

  void setAttendanceButtonStateForCheckOut() async {
    state = state.copyWith(type: AttendanceRecordCardButtonType.checkOut);
  }

  void setAttendanceButtonStateForFinished() async {
    await prefs.savePrefs(PrefsKey.recentAttendanceId, null);
    state = state.copyWith(type: AttendanceRecordCardButtonType.todayFinished);
  }

}

final recordCardStateProvider = StateNotifierProvider<AttendanceRecordCardNotifier, AttendanceRecordCardState>((ref) => AttendanceRecordCardNotifier());