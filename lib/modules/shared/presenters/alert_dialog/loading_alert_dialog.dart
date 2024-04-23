import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingAlertDialog extends StatelessWidget {
  const LoadingAlertDialog({
    super.key,
    required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(20.0),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height * 0.3,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 100,
                width: 100,
                child: LoadingIndicator(
                    indicatorType: Indicator.ballPulseSync,
                    colors: [
                      Colors.blueGrey.shade900,
                      Colors.blueGrey.shade900,
                      Colors.blueGrey.shade700,
                    ]
                )
            ),
            const SizedBox(height: 15),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Lato',
                color: Colors.blueGrey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


void showLoadingAlertDialog(
    BuildContext context,
    String message
    ) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingAlertDialog(
        message: message,
      )
  );
}