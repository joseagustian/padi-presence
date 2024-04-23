import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/shared/animations/shimmer_animation.dart';

class WorkingDaySummaryWidget extends StatelessWidget {

  final String targetWorkingDays;
  final String completedWorkingDays;
  final bool isLoading;

  const WorkingDaySummaryWidget({
    super.key,
    required this.targetWorkingDays,
    required this.completedWorkingDays,
    required this.isLoading
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(
            top: 10,
            left: 15,
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
              Strings.workingDays,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade800
              ),
            ),
            const SizedBox(height: 20),
            Text(
              Strings.thisMonth,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade800
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  EvaIcons.calendar_outline,
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
                        targetWorkingDays,
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
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  Strings.completed,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade800
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  EvaIcons.calendar,
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
                        completedWorkingDays,
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
