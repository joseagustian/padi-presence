import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/shared/animations/shimmer_animation.dart';

class WorkingHourSummaryWidget extends StatelessWidget {

  final String targetWorkingHours;
  final String completedWorkingHours;
  final bool isLoading;
  const WorkingHourSummaryWidget({
    super.key,
    required this.targetWorkingHours,
    required this.completedWorkingHours,
    required this.isLoading
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(
            top: 10,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  Strings.workingHours,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade800
                  ),
                ),
              ],
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
                  Bootstrap.hourglass_top,
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
                        targetWorkingHours,
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
                  Bootstrap.hourglass_bottom,
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
                        completedWorkingHours,
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
