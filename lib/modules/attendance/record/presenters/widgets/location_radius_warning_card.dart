import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:padi/core/constants/strings.dart';

class LocationRadiusWarningCard extends StatelessWidget {
  const LocationRadiusWarningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5
      ),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
      ),
      child: Row(
        children: [
          Icon(
            EvaIcons.alert_triangle,
            color: Colors.yellow.shade800,
            size: 24,
          ),
          Expanded(
            child: Text(
              Strings.outsideOfficeRadius,
              style: TextStyle(
                  color: Colors.blueGrey.shade900,
                  fontSize: 11,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
