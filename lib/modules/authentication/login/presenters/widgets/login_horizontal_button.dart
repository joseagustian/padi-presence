import 'package:flutter/material.dart';

class LoginHorizontalButton extends StatelessWidget {
  const LoginHorizontalButton({
    super.key,
    required this.helperText,
    required this.buttonText,
    required this.onTap,
  });

  final String helperText;
  final String buttonText;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          helperText,
          style: TextStyle(
            color: Colors.blueGrey[900],
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: onTap,
          splashFactory: NoSplash.splashFactory,
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.blueGrey[900],
              fontSize: 14,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
