import 'package:flutter/material.dart';

class RecordHistoryDetailSmallCard extends StatelessWidget {
  final IconData icon;
  final bool? flipIcon;
  final String title;
  final String? date;
  final String? time;
  const RecordHistoryDetailSmallCard({
    super.key,
    required this.icon,
    this.flipIcon = false,
    required this.title,
    this.date,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
            FittedBox(
              child: Row(
                children: [
                  Transform.flip(
                    flipX: flipIcon!,
                    child: Icon(
                      icon,
                      color: Colors.blueGrey.shade700,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.blueGrey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            FittedBox(
              child: Row(
                children: [
                  Text(
                    date!,
                    style: TextStyle(
                      color: Colors.blueGrey.shade500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    time!,
                    style: TextStyle(
                      color: Colors.blueGrey.shade500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
