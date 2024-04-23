import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';

class RegisterButton extends StatelessWidget {

  const RegisterButton({
    super.key,
    required this.isLoading,
    required this.onPressed
  });

  final bool isLoading;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.register.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gabarito',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.edit_note,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
