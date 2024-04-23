import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_detail/record_history_detail_activity_textfield.dart';

enum ProgressType {
  finish,
  onProgress,
  none
}

class RecordHistoryDetailActivity extends StatelessWidget {
  final TextEditingController activityController;
  final String? activity;
  final ProgressType progressType;

  const RecordHistoryDetailActivity({
    super.key,
    required this.activityController,
    this.activity,
    required this.progressType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.activityStatus,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            progressType == ProgressType.onProgress ? Strings.workOnProgress :
            progressType == ProgressType.finish ? Strings.workFinished : '-',
            style: TextStyle(
              fontSize: 14,
              color: Colors.blueGrey.shade500,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            Strings.workActivity,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          RecordHistoryDetailActivityTextField(
              activityController: activityController,
              activity: activity,
              enabled: false
          ),
        ],
      ),
    );
  }
}
