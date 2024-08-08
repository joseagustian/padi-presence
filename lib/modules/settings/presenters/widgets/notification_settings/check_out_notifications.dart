import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:time_picker_sheet/widget/sheet.dart';
import 'package:time_picker_sheet/widget/time_picker.dart';

class CheckOutNotificationsMenu extends StatefulWidget {
  final bool isNotificationEnabled;
  final bool widgetVisible;
  final bool isCheckOutNotificationEnabled;
  final String checkOutNotificationSchedule;
  final ValueChanged<bool> onCheckOutNotificationChanged;
  final ValueChanged<String> onCheckOutNotificationScheduleChanged;
  const CheckOutNotificationsMenu({
    super.key,
    required this.isNotificationEnabled,
    required this.widgetVisible,
    required this.isCheckOutNotificationEnabled,
    required this.checkOutNotificationSchedule,
    required this.onCheckOutNotificationChanged,
    required this.onCheckOutNotificationScheduleChanged
  });

  @override
  State<CheckOutNotificationsMenu> createState() => _CheckOutNotificationsMenuState();
}

class _CheckOutNotificationsMenuState extends State<CheckOutNotificationsMenu> {

  final ExpandableController _checkOutWidgetExpandableController = ExpandableController(
      initialExpanded: true,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: 20.0,
              left: 25.0
          ),
          child: Text(
            Strings.checkOutReminderSettings,
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
              right: 15.0
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
          child: Column(
            children: [
              Padding(
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
                        Strings.attendanceReminderNotification,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey.shade700,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: Switch(
                          value: widget.isCheckOutNotificationEnabled,
                          trackOutlineColor: WidgetStateProperty.all(Colors.blueGrey.shade100),
                          inactiveTrackColor: Colors.blueGrey.shade100,
                          activeTrackColor: Colors.blueGrey.shade800,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onChanged: widget.isNotificationEnabled ? widget.onCheckOutNotificationChanged : null,
                          activeColor: Colors.blueGrey,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ExpandableNotifier(
                controller: _checkOutWidgetExpandableController,
                child: Expandable(
                  collapsed: const SizedBox(),
                  expanded: Visibility(
                    visible: widget.widgetVisible,
                    child: Column(
                      children: [
                        Divider(
                          height: 1,
                          thickness: 0.5,
                          color: Colors.blueGrey.shade100,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0,
                              left: 15.0,
                              right: 15.0,
                              bottom: 8.0
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minHeight: 23,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Strings.attendanceReminderSchedule,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blueGrey.shade700,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                InkWell(
                                  splashFactory: NoSplash.splashFactory,
                                  onTap: () async {
                                    final result = await TimePicker.show<DateTime?>(
                                      context: context,
                                      sheet: TimePickerSheet(
                                        initialDateTime: DateFormat('HH:mm').parse(widget.checkOutNotificationSchedule),
                                        sheetTitle: Strings.selectReminderSchedule,
                                        hourTitle: Strings.scheduleHour,
                                        minuteTitle: Strings.scheduleMinute,
                                        saveButtonText: Strings.save.toUpperCase(),
                                        minHour: 17,
                                        maxHour: 20,
                                        hourInterval: 1,
                                        twoDigit: true,
                                        saveButtonColor: Colors.blueGrey.shade100,
                                        sheetCloseIconColor: Colors.blueGrey.shade900,
                                        hourTitleStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.blueGrey.shade700,
                                            fontWeight: FontWeight.bold
                                        ),
                                        minuteTitleStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.blueGrey.shade700,
                                            fontWeight: FontWeight.bold
                                        ),
                                        wheelNumberItemStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.blueGrey.shade300,
                                            fontWeight: FontWeight.bold
                                        ),
                                        wheelNumberSelectedStyle: TextStyle(
                                            fontSize: 20,
                                            color: Colors.blueGrey.shade800,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    );
                                    if (result != null) {
                                      final formattedTime = DateFormat('HH:mm').format(result);
                                      widget.onCheckOutNotificationScheduleChanged(formattedTime);
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.blueGrey[700],
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0,
                                          top: 5.0,
                                          bottom: 5.0
                                      ),
                                      child: Text(
                                        Strings.selectSchedule,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
