import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';

class CorrectionTextField extends StatefulWidget {

  final TextEditingController activityController;
  const CorrectionTextField({
    super.key,
    required this.activityController,
  });

  @override
  State<CorrectionTextField> createState() => _CorrectionTextFieldState();
}

class _CorrectionTextFieldState extends State<CorrectionTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blueGrey[700],
        ),
        child: TextFormField(
          controller: widget.activityController,
          keyboardType: TextInputType.text,
          cursorColor: Colors.white,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Lato',
            fontSize: 14,
            overflow: TextOverflow.ellipsis,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.sticky_note_2,
              color: Colors.white,
            ),
            hintText: Strings.workActivity,
            hintStyle: TextStyle(
                color: Colors.white,
                fontFamily: 'Lato',
                fontSize: 14
            ),
            errorStyle: TextStyle(
                color: Colors.transparent,
                fontSize: 0
            ),
          ),
        )
    );
  }
}
