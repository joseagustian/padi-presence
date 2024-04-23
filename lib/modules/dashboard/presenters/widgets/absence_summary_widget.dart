import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/shared/animations/shimmer_animation.dart';

class AbsenceSummaryWidget extends StatelessWidget {

  final String absence;
  final bool isLoading;
  const AbsenceSummaryWidget({
    super.key,
    required this.absence,
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
              Strings.absence,
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
                  Icons.event_busy_rounded,
                  color: Colors.blueGrey.shade700,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Shimmer(
                  linearGradient: shimmerGradient,
                  child: ShimmerLoading(
                    isLoading: isLoading,
                    child: Container(
                      color : isLoading ? Colors.grey.shade300 : Colors.transparent,
                      child: Text(
                        absence,
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
