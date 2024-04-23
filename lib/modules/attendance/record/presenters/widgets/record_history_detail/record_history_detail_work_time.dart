import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/core/utils/date_time_formatter.dart';

import 'record_history_detail_small_card.dart';

class RecordHistoryDetailWorkTime extends StatelessWidget {
  final String? scheduleIn;
  final String? scheduleOut;
  final String? checkInTime;
  final String? checkOutTime;
  const RecordHistoryDetailWorkTime({
    super.key,
    this.scheduleIn,
    this.scheduleOut,
    this.checkInTime,
    this.checkOutTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RecordHistoryDetailSmallCard(
                icon: Icons.login,
                title: Strings.scheduleIn,
                date: formatWorkingDateAndTime(scheduleIn ?? ''),
                time: getTimeFromAttendanceTime(scheduleIn ?? ''),
              ),
              const SizedBox(width: 10),
              RecordHistoryDetailSmallCard(
                icon: BoxIcons.bx_time_five,
                flipIcon: true,
                title: Strings.timeIn,
                date: formatWorkingDateAndTime(checkInTime ?? ''),
                time: getTimeFromAttendanceTime(checkInTime ?? ''),
              )
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RecordHistoryDetailSmallCard(
                icon: Icons.logout,
                title: Strings.scheduleOut,
                date: formatWorkingDateAndTime(scheduleOut ?? ''),
                time: getTimeFromAttendanceTime(scheduleOut ?? ''),
              ),
              const SizedBox(width: 10),
              RecordHistoryDetailSmallCard(
                icon: BoxIcons.bx_time_five,
                title: Strings.timeOut,
                date: formatWorkingDateAndTime(checkOutTime ?? ''),
                time: getTimeFromAttendanceTime(checkOutTime ?? ''),
              )
            ],
          ),
        )
      ],
    );
  }
}
