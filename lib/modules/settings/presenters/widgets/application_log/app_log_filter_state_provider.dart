
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppLogFilterType{
  all,
  info,
  warning,
  error,
}

class AppLogFilterState {
  final AppLogFilterType filterType;

  AppLogFilterState({
    required this.filterType,
  });

  AppLogFilterState copyWith({
    AppLogFilterType? filterType,
  }) {
    return AppLogFilterState(
      filterType: filterType ?? this.filterType,
    );
  }

}

class AppLogFilterStateNotifier extends StateNotifier<AppLogFilterState> {
  AppLogFilterStateNotifier() : super(AppLogFilterState(filterType: AppLogFilterType.all));

  void setFilterType(AppLogFilterType filterType) {
    state = state.copyWith(filterType: filterType);
  }

}

final appLogFilterProvider = StateNotifierProvider.autoDispose<AppLogFilterStateNotifier, AppLogFilterState>((ref) {
  return AppLogFilterStateNotifier();
});