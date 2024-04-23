import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';

class CorrectionDialogButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  const CorrectionDialogButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.cancel,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gabarito',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5.0),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: onPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gabarito',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
