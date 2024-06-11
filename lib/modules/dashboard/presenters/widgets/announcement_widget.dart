import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';

class AnnouncementWidget extends StatelessWidget {
  const AnnouncementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Expanded(
                child: Text(
                  Strings.announcement,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade800
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 14,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
              'Jangan lupa untuk mencatat kehadiran setiap hari ya!',
              style: TextStyle(
                fontSize: 12,
                color: Colors.blueGrey.shade700
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 15),
          Text(
              'Selasa, 4 Januari 2024',
            style: TextStyle(
              fontSize: 12,
              color: Colors.blueGrey.shade700
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            'HRD Mega Giga Solusindo',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade700
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
