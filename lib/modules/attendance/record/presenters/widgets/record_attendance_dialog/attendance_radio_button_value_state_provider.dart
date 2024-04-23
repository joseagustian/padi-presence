
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RadioButtonValueState {
  final String workType;
  final String progressType;
  final bool isSelected;

  const RadioButtonValueState(
    this.workType,
    this.progressType,
    this.isSelected,
  );

  RadioButtonValueState copyWith({
    String? workType,
    String? progressType,
    bool? isSelected,
  }) {
    return RadioButtonValueState(
      workType ?? this.workType,
      progressType ?? this.progressType,
      isSelected ?? this.isSelected,
    );
  }
}

class RadioButtonValueStateProvider extends StateNotifier<RadioButtonValueState> {
  RadioButtonValueStateProvider() : super(const RadioButtonValueState(
    '',
    '',
    false,
  ));

  void setWorkType(String workType) {
    state = state.copyWith(workType: workType);
  }

  void setProgressType(String progressType) {
    state = state.copyWith(progressType: progressType);
  }

  void setIsSelected(bool isSelected) {
    state = state.copyWith(isSelected: isSelected);
  }

  String get getWorkType => state.workType;
  String get getProgressType => state.progressType;

  void reset() {
    state = const RadioButtonValueState(
      '',
      '',
      false,
    );
  }
}

final radioButtonValueStateProvider = StateNotifierProvider.autoDispose<RadioButtonValueStateProvider, RadioButtonValueState>((ref) {
  return RadioButtonValueStateProvider();
});