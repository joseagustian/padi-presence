import 'package:flutter/material.dart';

class RecordHistoryDetailActivityTextField extends StatefulWidget {
  final TextEditingController activityController;
  final String? activity;
  final bool enabled;

  const RecordHistoryDetailActivityTextField({
    super.key,
    required this.activityController,
    required this.enabled,
    this.activity,
  });

  @override
  State<RecordHistoryDetailActivityTextField> createState() => _RecordHistoryDetailActivityTextFieldState();
}

class _RecordHistoryDetailActivityTextFieldState extends State<RecordHistoryDetailActivityTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
          right: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blueGrey[700],
        ),
        child: TextFormField(
          enabled: widget.enabled,
          controller: widget.activityController,
          keyboardType: TextInputType.text,
          cursorColor: Colors.white,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Lato',
            fontSize: 14,
            overflow: TextOverflow.ellipsis,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Icon(
              Icons.sticky_note_2,
              color: Colors.white,
            ),
            hintText: widget.activity,
            hintStyle: const TextStyle(
                color: Colors.white,
                fontFamily: 'Lato',
                fontSize: 14
            ),
            errorStyle: const TextStyle(
                color: Colors.transparent,
                fontSize: 0
            ),
          ),
        )
    );
  }
}
