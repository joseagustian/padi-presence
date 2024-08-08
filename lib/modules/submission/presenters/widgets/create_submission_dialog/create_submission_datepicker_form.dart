import 'package:flutter/material.dart';

class CreateSubmissionDatePickerForm extends StatefulWidget {
  final Function onTap;
  final String hintText;
  final IconData prefixIcon;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CreateSubmissionDatePickerForm({
    super.key,
    required this.onTap,
    required this.hintText,
    required this.prefixIcon,
    required this.textInputAction,
    required this.controller,
    required this.validator,
  });

  @override
  State<CreateSubmissionDatePickerForm> createState() => _CreateSubmissionDatePickerFormState();
}

class _CreateSubmissionDatePickerFormState extends State<CreateSubmissionDatePickerForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.blueGrey[700],
      ),
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: TextFormField(
          enabled: false,
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.center,
          cursorColor: Colors.white,
          validator: widget.validator,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: 'Lato',
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
                fontFamily: 'Lato',
                fontSize: 12
            ),
            errorStyle: const TextStyle(
                color: Colors.transparent,
                fontSize: 0
            ),
          ),
        ),
      ),
    );
  }
}
