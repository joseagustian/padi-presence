import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/utils/app_logger.dart';
import 'package:padi/modules/attendance/record/attendance_history_detail_provider.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_detail/record_history_detail_activity.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_detail/record_history_detail_work_location.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_detail/record_history_detail_work_time.dart';

import '../record_history_list/attendance_record_history_card.dart';
import 'correction_button_state_provider.dart';

class RecordHistoryDetail extends ConsumerStatefulWidget {
  final String? attendanceId;
  const RecordHistoryDetail({
    super.key,
    this.attendanceId
  });

  @override
  ConsumerState<RecordHistoryDetail> createState() => _RecordHistoryDetailState();
}

class _RecordHistoryDetailState extends ConsumerState<RecordHistoryDetail> {
  final TextEditingController activityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final AppLogger logger = AppLogger();
    return Expanded(
      child: ref.watch(attendanceHistoryDetailProvider(widget.attendanceId!)).when(
          data: (historyDetail) {
            Future.delayed(const Duration(microseconds: 10), () {
              bool isFinished = historyDetail.data[0].checkOut?.checkOutTime != null;
              ref.read(attendanceCorrectionButtonProvider.notifier).setFinished(isFinished);
            });
            return RefreshIndicator(
              backgroundColor: Colors.blueGrey.shade800,
              color: Colors.blueGrey.shade100,
              onRefresh: () async {
                logger.recordLog(LoggerMessage.refreshAttendanceHistoryDetail, LogType.info);
                ref.refresh(getAttendanceHistoryDetailProvider(widget.attendanceId!)).attendanceHistoryDetail(widget.attendanceId!);
              },
              child: RawScrollbar(
                thumbVisibility: true,
                trackVisibility: true,
                thumbColor: Colors.blueGrey[900],
                trackColor: Colors.blueGrey[300],
                thickness: 3,
                padding: const EdgeInsets.only(right: 2),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      RecordHistoryDetailWorkTime(
                        scheduleIn: historyDetail.data[0].scheduleIn,
                        scheduleOut: historyDetail.data[0].scheduleOut,
                        checkInTime: historyDetail.data[0].checkIn?.checkInTime,
                        checkOutTime: historyDetail.data[0].checkOut?.checkOutTime,
                      ),
                      RecordHistoryDetailWorkLocation(
                        workType: historyDetail.data[0].workType == 'WFO' ? WorkType.wfo : WorkType.wfh,
                        workDuration: historyDetail.data[0].workingHours,
                        checkInLat: historyDetail.data[0].checkIn?.checkInLatitude ?? '',
                        checkInLong: historyDetail.data[0].checkIn?.checkInLongitude ?? '',
                        checkOutLat: historyDetail.data[0].checkOut?.checkOutLatitude ?? '',
                        checkOutLong: historyDetail.data[0].checkOut?.checkOutLongitude ?? '',
                      ),
                      RecordHistoryDetailActivity(
                          activityController: activityController,
                          activity: historyDetail.data[0].activity,
                          progressType: historyDetail.data[0].note == Strings.typeFinished ? ProgressType.finish :
                          historyDetail.data[0].note == Strings.typeOnProgress ? ProgressType.onProgress : ProgressType.none
                      ),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
              ),
            );
          },
          error: (e, s) => Center(
              child: Text(
                  e.toString().replaceAll('Exception: ', ''),
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey.shade900,
                  )
              )
          ),
          loading: () => Center(
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
          ),
      ),
    );
  }
}
