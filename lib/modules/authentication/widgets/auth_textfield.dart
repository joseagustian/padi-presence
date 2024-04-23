import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {


  final String hintText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool enabled;
  final TextEditingController controller;
  final String? Function(String?)? validator;


  const AuthTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.keyboardType,
    required this.textInputAction,
    required this.obscureText,
    required this.enabled,
    required this.controller,
    required this.validator,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    if (!widget.obscureText) { obscureText = false;}
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.blueGrey[700],
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: obscureText,
        enabled: widget.enabled,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        cursorColor: Colors.white,
        validator: widget.validator,
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
          suffixIcon: widget.obscureText
              ? IconButton(
            icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.blueGrey[200]
            ),
            onPressed: () => setState(() {
              obscureText = !obscureText;
            }),
          ) : null,
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
    );
  }
}
