import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/shared/animations/shimmer_animation.dart';

class LeaveSummaryWidget extends StatelessWidget {
  final String leaveDay;
  final bool isLoading;
  const LeaveSummaryWidget({
    super.key,
    required this.leaveDay,
    required this.isLoading
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(
          top: 10,
          right: 15,
          bottom: 15,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.leave,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade800
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  Icons.event_note,
                  color: Colors.blueGrey.shade700,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Shimmer(
                  linearGradient: shimmerGradient,
                  child: ShimmerLoading(
                    isLoading: isLoading,
                    child: Container(
                      color: isLoading ? Colors.grey.shade100 : Colors.transparent,
                      child: Text(
                        leaveDay,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isLoading ? Colors.transparent : Colors.blueGrey.shade700
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
