
class MonthlyActivity {
  int status;
  MonthlyActivityData data;
  String message;

  MonthlyActivity({
    required this.status,
    required this.data,
    required this.message,
  });

}

class MonthlyActivityData {
  String totalWorkingDay;
  String employeeWorkingDay;
  String totalWorkingHour;
  String employeeWorkingHour;
  String notPresent;
  String wfh;
  String wfo;
  String late;

  MonthlyActivityData({
    required this.totalWorkingDay,
    required this.employeeWorkingDay,
    required this.totalWorkingHour,
    required this.employeeWorkingHour,
    required this.notPresent,
    required this.wfh,
    required this.wfo,
    required this.late,
  });

}