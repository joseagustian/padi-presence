import 'package:flutter/material.dart';

class UpdateProfileTextField extends StatefulWidget {
  final IconData prefixIcon;
  final TextEditingController updateProfileController;
  final String hintText;
  const UpdateProfileTextField({
    super.key,
    required this.prefixIcon,
    required this.updateProfileController,
    required this.hintText
  });

  @override
  State<UpdateProfileTextField> createState() => _UpdateProfileTextFieldState();
}

class _UpdateProfileTextFieldState extends State<UpdateProfileTextField> {
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
          controller: widget.updateProfileController,
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
        )
    );
  }
}
