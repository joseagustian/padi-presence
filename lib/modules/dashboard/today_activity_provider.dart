import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/utils/shared_preferences.dart';

class TodayActivityState {
  String checkInTime;
  String checkOutTime;
  String workingHours;

  TodayActivityState({
    required this.checkInTime,
    required this.checkOutTime,
    required this.workingHours,
  });

  TodayActivityState copyWith({
    String? checkInTime,
    String? checkOutTime,
    String? workingHours,
  }) {
    return TodayActivityState(
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      workingHours: workingHours ?? this.workingHours,
    );
  }
}


class TodayActivityProvider extends StateNotifier<TodayActivityState> {

  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  TodayActivityProvider() : super(TodayActivityState(
    checkInTime: '--:--',
    checkOutTime: '--:--',
    workingHours: '--:--',
  )) {
    _initializeState();
  }

  void _initializeState() async {
    final checkInTime = await prefs.getPrefs(PrefsKey.attendanceCheckInTime);
    final checkOutTime = await prefs.getPrefs(PrefsKey.attendanceCheckOutTime);
    final workingHours = await prefs.getPrefs(PrefsKey.attendanceWorkingHours);

    state = state.copyWith(
      checkInTime: checkInTime ?? '--:--',
      checkOutTime: checkOutTime ?? '--:--',
      workingHours: workingHours ?? '--:--',
    );
  }

  void getTodayActivity() async {

    final checkInTime = await prefs.getPrefs(PrefsKey.attendanceCheckInTime);
    final checkOutTime = await prefs.getPrefs(PrefsKey.attendanceCheckOutTime);
    final workingHours = await prefs.getPrefs(PrefsKey.attendanceWorkingHours);

    state = state.copyWith(
      checkInTime: checkInTime ?? '--:--',
      checkOutTime: checkOutTime ?? '--:--',
      workingHours: workingHours ?? '--:--',
    );
  }

}

final todayActivityProvider = StateNotifierProvider<TodayActivityProvider, TodayActivityState>((ref) {
  return TodayActivityProvider();
});