import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/shared/presenters/date_and_time/date_and_time_provider.dart';

class RecordHistoryListHeader extends ConsumerWidget {
  const RecordHistoryListHeader({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.blueGrey.shade50,
            width: 1.0,
          ),
          bottom: BorderSide(
            color: Colors.blueGrey.shade50,
            width: 1.0,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Strings.attendanceRecordHistory,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade900,
            ),
          ),
          Text(
            ref.watch(monthNowProvider),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
