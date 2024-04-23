import 'package:flutter/material.dart';
import 'package:padi/core/constants/strings.dart';

class GeneralNotificationMenu extends StatefulWidget {
  final bool isNotificationEnabled;
  final ValueChanged<bool> onNotificationChanged;
  const GeneralNotificationMenu({
    super.key,
    required this.isNotificationEnabled,
    required this.onNotificationChanged
  });

  @override
  State<GeneralNotificationMenu> createState() => _GeneralNotificationMenuState();
}

class _GeneralNotificationMenuState extends State<GeneralNotificationMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 25.0,
          ),
          child: Text(
            Strings.notification,
            style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey.shade600,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
              top: 5.0,
              left: 15.0,
              right: 15.0,
              bottom: 20.0
          ),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                )
              ]
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10.0,
                left: 15.0,
                right: 15.0,
                bottom: 10.0
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 23,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.showNotifications,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey.shade700,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Switch(
                      value: widget.isNotificationEnabled,
                      trackOutlineColor: MaterialStateProperty.all(Colors.blueGrey.shade100),
                      inactiveTrackColor: Colors.blueGrey.shade100,
                      activeTrackColor: Colors.blueGrey.shade800,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (value) {
                        widget.onNotificationChanged(value);
                      },
                      activeColor: Colors.blueGrey,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
