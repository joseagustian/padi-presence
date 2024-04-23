import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';

class UpdateProfileButton extends StatelessWidget {
  final Function() onPressed;
  const UpdateProfileButton({
    super.key,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          backgroundColor: Colors.blueGrey.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.updateProfile.toUpperCase(),
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade50,
                  fontFamily: 'Gabarito',
                  letterSpacing: 1.5
              ),
            ),
          ],
        )
    );
  }
}
