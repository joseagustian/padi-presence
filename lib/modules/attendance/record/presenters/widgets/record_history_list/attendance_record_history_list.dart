import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/routes/router.dart';
import 'package:padi/core/utils/app_logger.dart';
import 'package:padi/modules/attendance/record/attendances_history_provider.dart';
import 'package:padi/modules/attendance/record/padi_scheduler_provider.dart';
import 'package:padi/modules/attendance/record/presenters/validators/validate_padi_scheduler.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_attendance_dialog/check_out/record_check_out_alert_dialog.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_list/attendance_record_history_card.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_list/record_history_card.dart';

class AttendanceRecordHistoryList extends ConsumerWidget {
  const AttendanceRecordHistoryList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final AppLogger logger = AppLogger();
    return Expanded(
      child: ref.watch(attendancesHistoryProvider).when(
        data: (history) {
          if (history.data?.isEmpty ?? true) {
            return Center(child: Text(
                Strings.noAttendanceHistory,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey.shade900
                )
            ));
          } else {
            history.data?.sort((a, b) {
              return b.attendanceDate?.compareTo(a.attendanceDate ?? '') ?? 0;
            });
            return RefreshIndicator(
              backgroundColor: Colors.blueGrey.shade800,
              color: Colors.blueGrey.shade100,
              onRefresh: () async {
                logger.recordLog(LoggerMessage.refreshAttendanceHistoryList, LogType.info);
                ref.refresh(getAttendancesHistoryProvider).attendancesHistory();
              },
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: history.data?.length,
                  itemBuilder: (context, index) {
                    return RecordHistoryCard(
                      isEmptyCard: history.data?[index].checkIn?.checkInTime == '' ? true : false,
                      workType: history.data?[index].workType == 'WFO' ? WorkType.wfo : WorkType.wfh,
                      date: history.data?[index].checkIn?.checkInDate ?? '',
                      day: history.data?[index].checkIn?.checkInDay ?? '',
                      checkInClock: history.data?[index].checkIn?.checkInClock ?? '',
                      checkOutClock: history.data?[index].checkOut?.checkOutClock ?? '',
                      activity: history.data?[index].activity ?? '',
                      workingHours: history.data?[index].workingHours ?? '',
                      attendanceDate: history.data?[index].attendanceDate ?? '',
                      attendanceDay: history.data?[index].attendanceDay ?? '',
                      isDayOff: history.data?[index].dayOff == 'Off' ? true : false,
                      onTap: () {
                        router.push(
                            '/attendance-record-detail/${history.data?[index].attendanceId}',
                        );
                      },
                      onCheckoutTap: () {
                        showRecordCheckOutAlertDialog(
                            context,
                            '${history.data?[index].attendanceId}',
                        );
                      },
                    );
                  }
              ),
            );
          }
        },
        loading: () {
          validatePadiScheduler(context, ref.watch(padiSchedulerProvider));
          return Center(
              child: SizedBox(
                width: 50.0,
                child: LoadingIndicator(
                    indicatorType: Indicator.ballSpinFadeLoader,
                    colors: [
                      Colors.blueGrey.shade600,
                      Colors.blueGrey.shade800,
                      Colors.blueGrey.shade600,
                      Colors.blueGrey.shade800,
                    ]
                ),
              )
          );
        },
        error: (e, s) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    e.toString().replaceAll('Exception: ', ''),
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey.shade900,
                    )
                ),
                const SizedBox(height: 5.0),
                InkWell(
                  splashFactory: NoSplash.splashFactory,
                  onTap: () {
                    ref.refresh(getAttendancesHistoryProvider).attendancesHistory();
                  },
                  child: Text(
                      Strings.tapToRetry,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.blueAccent.shade400,
                      )
                  )
                )
              ],
            ),
        ),
      )
    );
  }
}
