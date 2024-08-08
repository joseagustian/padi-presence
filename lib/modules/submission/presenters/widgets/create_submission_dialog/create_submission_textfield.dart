import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';

class CreateSubmissionTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;

  const CreateSubmissionTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon
  });

  @override
  State<CreateSubmissionTextField> createState() => _CreateSubmissionTextFieldState();
}

class _CreateSubmissionTextFieldState extends State<CreateSubmissionTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blueGrey[700],
        ),
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.start,
          controller: widget.controller,
          keyboardType: TextInputType.text,
          cursorColor: Colors.white,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Lato',
            overflow: TextOverflow.ellipsis,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              widget.prefixIcon,
              color: Colors.white,
              size: 16,
            ),
            hintText: widget.hintText,
            hintStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Lato',
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