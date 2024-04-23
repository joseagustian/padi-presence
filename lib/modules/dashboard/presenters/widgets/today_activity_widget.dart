import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/modules/shared/presenters/date_and_time/stream_time_and_date_provider.dart';

class TodayActivityWidget extends ConsumerWidget {
  const TodayActivityWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(streamDateAndTimeProvider);
    return Container(
      margin: const EdgeInsets.only(
          top: 20,
          left: 15,
          right: 15
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 2,
            offset: const Offset(0, 1),
          )
        ]
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  state.timeAndDate,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade800
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.update,
                    color: Colors.blueGrey.shade700,
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '--:--',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade700
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.history,
                    color: Colors.blueGrey.shade700,
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '--:--',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade700
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.alarm_on,
                    color: Colors.blueGrey.shade700,
                    size: 18,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '--:--',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade700
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
