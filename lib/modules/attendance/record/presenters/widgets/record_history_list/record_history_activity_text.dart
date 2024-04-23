import 'package:flutter/material.dart';

class RecordHistoryActivityText extends StatelessWidget {
  final String text;
  const RecordHistoryActivityText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.blueGrey.shade700,
        ),
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
