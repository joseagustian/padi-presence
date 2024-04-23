import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MonthlyScheduleCalendar extends StatelessWidget {
  const MonthlyScheduleCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime firstDayOfMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
    DateTime lastDayOfMonth = DateTime(DateTime.now().year, DateTime.now().month + 1, 0);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: SfCalendar(
        view: CalendarView.month,
        firstDayOfWeek: 7,
        showCurrentTimeIndicator: true,
        headerStyle: CalendarHeaderStyle(
          textAlign: TextAlign.center,
          textStyle: TextStyle(
            fontSize: 18,
            color: Colors.blueGrey.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
        monthViewSettings: const MonthViewSettings(
          showTrailingAndLeadingDates: false,
        ),
        monthCellBuilder: (BuildContext context, MonthCellDetails details) {
          bool isWeekend = details.date.weekday == DateTime.sunday || details.date.weekday == DateTime.saturday;
          bool isTodayWeekend = isWeekend && details.date.day == DateTime.now().day;
          bool isToday = details.date.day == DateTime.now().day;
          return Stack(
            children: [
              Center(
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: isTodayWeekend ? Colors.red.shade400
                        : isToday ? Colors.blueGrey.shade600
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Center(
                child: Text(
                  details.date.day.toString(),
                  style: TextStyle(
                    color: isTodayWeekend ? Colors.white
                        : isWeekend ? Colors.red
                        : isToday ? Colors.white : Colors.blueGrey.shade600,
                  ),
                ),
              ),
            ],
          );
        },
        minDate: firstDayOfMonth,
        maxDate: lastDayOfMonth,
      ),
    );
  }
}
