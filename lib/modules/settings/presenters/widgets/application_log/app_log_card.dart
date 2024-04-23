import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/utils/app_logger.dart';

class AppLogCard extends StatelessWidget {
  final String logTime;
  final String logMessage;
  final LogType logType;
  const AppLogCard({
    super.key,
    required this.logTime,
    required this.logMessage,
    required this.logType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 15.0,
        left: 15,
        right: 15,
      ),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.all(
            Radius.circular(10.0),
          ),
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
          Row(
            children: [
              Icon(
                logType == LogType.info
                    ? EvaIcons.info
                    : logType == LogType.warning
                    ? EvaIcons.alert_triangle
                    : Icons.error,
                color: logType == LogType.info
                    ? Colors.blueAccent.shade400
                    : logType == LogType.warning
                    ? Colors.amber.shade600
                    : Colors.redAccent.shade400,
                size: 18,
              ),
              const SizedBox(width: 5.0),
              Text(
                logType == LogType.info
                    ? "Informasi"
                    : logType == LogType.warning
                    ? "Peringatan"
                    : "Kesalahan",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: logType == LogType.info
                      ? Colors.blueAccent.shade400
                      : logType == LogType.warning
                      ? Colors.amber.shade600
                      : Colors.redAccent.shade400,
                ),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            logMessage,
            style: TextStyle(
              fontSize: 12,
              color: Colors.blueGrey.shade800,
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            logTime,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
