import 'package:flutter/material.dart';

class MessengerAlertDialogButton extends StatelessWidget {
  const MessengerAlertDialogButton({
    super.key,
    required this.buttonText,
    required this.isSuccess,
    required this.onPressed,
  });
  final String buttonText;
  final bool isSuccess;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isSuccess ? Colors.blueGrey[900] : Colors.red[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
      ),
    );
  }
}
