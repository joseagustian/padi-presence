import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';

class LoginButton extends StatelessWidget {

  const LoginButton({
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Strings.login.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gabarito',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.input_sharp,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
