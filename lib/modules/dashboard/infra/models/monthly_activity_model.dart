class MonthlyActivityModel {
  int status;
  MonthlyActivityDataModel data;
  String message;

  MonthlyActivityModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory MonthlyActivityModel.fromJson(Map<String, dynamic> json) {
    return MonthlyActivityModel(
      status: json['status'],
      data: MonthlyActivityDataModel.fromJson(json['data']),
      message: json['message'],
    );
  }

}

class MonthlyActivityDataModel {
  String totalWorkingDay;
  String employeeWorkingDay;
  String totalWorkingHour;
  String employeeWorkingHour;
  String notPresent;
  String workFromHome;
  String workFromOffice;
  String late;

  MonthlyActivityDataModel({
    required this.totalWorkingDay,
    required this.employeeWorkingDay,
    required this.totalWorkingHour,
    required this.employeeWorkingHour,
    required this.notPresent,
    required this.workFromHome,
    required this.workFromOffice,
    required this.late,
  });

  factory MonthlyActivityDataModel.fromJson(Map<String, dynamic> json) {
    return MonthlyActivityDataModel(
      totalWorkingDay: json['total_working_day'],
      employeeWorkingDay: json['employee_working_day'],
      totalWorkingHour: json['standard_working_hour'],
      employeeWorkingHour: json['employee_working_hours'],
      notPresent: json['not_present'],
      workFromHome: json['wfh'],
      workFromOffice: json['wfo'],
      late: json['late'],
    );
  }
}

