
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/utils/app_logger.dart';
import 'package:padi/core/utils/date_time_formatter.dart';

import 'domains/usecases/monthly_activity_usecase.dart';
import 'monthly_activity_provider.dart';

class MonthlyActivitySummaryState {
  String standardWorkingDay;
  String employeeWorkingDay;
  String standardWorkingHour;
  String employeeWorkingHour;
  String notPresentDay;
  String workFromHomeDay;
  String workFromOfficeDay;
  String lateDay;
  String leaveDay;
  bool isLoading = false;

  MonthlyActivitySummaryState({
    required this.standardWorkingDay,
    required this.employeeWorkingDay,
    required this.standardWorkingHour,
    required this.employeeWorkingHour,
    required this.notPresentDay,
    required this.workFromHomeDay,
    required this.workFromOfficeDay,
    required this.lateDay,
    required this.leaveDay,
    required this.isLoading,
  });

  MonthlyActivitySummaryState copyWith({
    String? standardWorkingDay,
    String? employeeWorkingDay,
    String? standardWorkingHour,
    String? employeeWorkingHour,
    String? notPresentDay,
    String? workFromHomeDay,
    String? workFromOfficeDay,
    String? lateDay,
    String? leaveDay,
    bool? isLoading,
  }) {
    return MonthlyActivitySummaryState(
      standardWorkingDay: standardWorkingDay ?? this.standardWorkingDay,
      employeeWorkingDay: employeeWorkingDay ?? this.employeeWorkingDay,
      standardWorkingHour: standardWorkingHour ?? this.standardWorkingHour,
      employeeWorkingHour: employeeWorkingHour ?? this.employeeWorkingHour,
      notPresentDay: notPresentDay ?? this.notPresentDay,
      workFromHomeDay: workFromHomeDay ?? this.workFromHomeDay,
      workFromOfficeDay: workFromOfficeDay ?? this.workFromOfficeDay,
      lateDay: lateDay ?? this.lateDay,
      leaveDay: leaveDay ?? this.leaveDay,
      isLoading: isLoading ?? this.isLoading,
    );
  }

}

class MonthlyActivitySummaryProvider extends StateNotifier<MonthlyActivitySummaryState> {

  final MonthlyActivityUseCase _monthlyActivityUseCase;

  MonthlyActivitySummaryProvider(this._monthlyActivityUseCase) : super(MonthlyActivitySummaryState(
    standardWorkingDay: '0 Hari',
    employeeWorkingDay: '0 Hari',
    standardWorkingHour: '00j 00m',
    employeeWorkingHour: '00j 00m',
    notPresentDay: '0 Hari',
    workFromHomeDay: '0',
    workFromOfficeDay: '0',
    lateDay: '0 Hari',
    leaveDay: '0 Hari',
    isLoading: false,
  )) {
    getWorkingTimeSummary();
  }

  AppLogger logger = AppLogger();

  Future<void> getWorkingTimeSummary() async {
    logger.recordLog(LoggerMessage.fetchWorkingTimeSummary, LogType.info);
    try {
      state = state.copyWith(isLoading: true);

      final monthlyActivity = await _monthlyActivityUseCase.getMonthlyActivity();

      final standardWorkingDay = monthlyActivity.data.totalWorkingDay;
      final employeeWorkingDay = monthlyActivity.data.employeeWorkingDay;
      final standardWorkingHour = monthlyActivity.data.totalWorkingHour;
      final employeeWorkingHour = monthlyActivity.data.employeeWorkingHour;
      final notPresentDay = monthlyActivity.data.notPresent;
      final workFromHomeDay = monthlyActivity.data.wfh;
      final workFromOfficeDay = monthlyActivity.data.wfo;
      final lateDay = monthlyActivity.data.late;

      state = state.copyWith(
        standardWorkingDay: formatSummaryDays(standardWorkingDay),
        employeeWorkingDay: formatSummaryDays(employeeWorkingDay),
        standardWorkingHour: formatSummaryWorkingHour('$standardWorkingHour:00'),
        employeeWorkingHour: formatSummaryWorkingHour(employeeWorkingHour),
        notPresentDay: formatSummaryDays(notPresentDay),
        workFromHomeDay: workFromHomeDay,
        workFromOfficeDay: workFromOfficeDay,
        lateDay: formatSummaryDays(lateDay),
      );
    } catch (e) {
      logger.recordLog(LoggerMessage.failedToFetchWorkingTimeSummary, LogType.error);
      state = state.copyWith(
        standardWorkingDay: formatSummaryDays('0'),
        employeeWorkingDay: formatSummaryDays('0'),
        standardWorkingHour: formatSummaryWorkingHour('00:00'),
        employeeWorkingHour: formatSummaryWorkingHour('00:00'),
        notPresentDay: formatSummaryDays('0'),
        workFromHomeDay: '0',
        workFromOfficeDay: '0',
        lateDay: formatSummaryDays('0'),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

}

final monthlyActivitySummaryProvider = StateNotifierProvider<MonthlyActivitySummaryProvider, MonthlyActivitySummaryState>((ref) {
  return MonthlyActivitySummaryProvider(
    ref.watch(monthlyActivityUseCaseProvider),
  );
});