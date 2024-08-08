import 'package:flutter/material.dart';

class UpdateProfileDatePickerForm extends StatefulWidget {
  final Function onTap;
  final String hintText;
  final IconData prefixIcon;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  const UpdateProfileDatePickerForm({
    super.key,
    required this.onTap,
    required this.hintText,
    required this.prefixIcon,
    required this.textInputAction,
    required this.controller,
  });

  @override
  State<UpdateProfileDatePickerForm> createState() => _UpdateProfileDatePickerFormState();
}

class _UpdateProfileDatePickerFormState extends State<UpdateProfileDatePickerForm> {
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
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.start,
          enabled: false,
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          cursorColor: Colors.white,
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Lato',
            fontSize: 14,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              widget.prefixIcon,
              color: Colors.white,
            ),
            hintText: widget.hintText,
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
        ),
      ),
    );
  }
}
