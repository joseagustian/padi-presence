import 'package:flutter_riverpod/flutter_riverpod.dart';

class AttendanceCorrectionButtonState{

  final bool isFinished;

  AttendanceCorrectionButtonState({
    required this.isFinished,
  });

  AttendanceCorrectionButtonState copyWith({
    bool? isFinished,
    bool? isLoading,
  }) {
    return AttendanceCorrectionButtonState(
      isFinished: isFinished ?? this.isFinished,
    );
  }

}

class AttendanceCorrectionButtonStateProvider extends StateNotifier<AttendanceCorrectionButtonState> {

  AttendanceCorrectionButtonStateProvider() : super(AttendanceCorrectionButtonState(
    isFinished: false,
  )) {
    init();
  }

  void init() {
    state = state.copyWith(
      isFinished: false,
    );
  }

  void reset() {
    state = state.copyWith(
      isFinished: false,
    );
  }

  void setFinished(bool isFinished) {
    state = state.copyWith(
      isFinished: isFinished,
    );
  }

}

final attendanceCorrectionButtonProvider = StateNotifierProvider<AttendanceCorrectionButtonStateProvider, AttendanceCorrectionButtonState>((ref) {
  return AttendanceCorrectionButtonStateProvider();
});