
class AttendancesHistoryModel {
  int status;
  List<AttendanceHistoryDataModel>? data;
  String message;

  AttendancesHistoryModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory AttendancesHistoryModel.fromJson(Map<String, dynamic> json) {
    return AttendancesHistoryModel(
      status: json['status'],
      data: json['data'] != null ? (json['data'] as List).map((i) => AttendanceHistoryDataModel.fromJson(i)).toList() : null,
      message: json['message'],
    );
  }

}

class AttendanceHistoryDataModel {
  String? attendanceId;
  CheckInDataModel? checkIn;
  CheckOutDataModel? checkOut;
  String? note;
  String? activity;
  String? workType;
  String? workingHours;
  String? attendanceDate;
  String? dayOff;

  AttendanceHistoryDataModel({
    this.attendanceId,
    this.checkIn,
    this.checkOut,
    this.note,
    this.activity,
    this.workType,
    this.workingHours,
    this.attendanceDate,
    this.dayOff,
  });

  factory AttendanceHistoryDataModel.fromJson(Map<String, dynamic> json) {
    return AttendanceHistoryDataModel(
      attendanceId: json['transaction_id'],
      checkIn: json['checkin'] != null ? CheckInDataModel.fromJson(json['checkin']) : null,
      checkOut: json['checkout'] != null ? CheckOutDataModel.fromJson(json['checkout']) : null,
      note: json['note'],
      activity: json['activity'],
      workType: json['work_type'],
      workingHours: json['working_hours'],
      attendanceDate: json['day'],
      dayOff: json['day_off'],
    );
  }

}

class CheckInDataModel {
  String? checkInTime;
  String? checkInLatitude;
  String? checkInLongitude;
  String? status;

  CheckInDataModel({
    this.checkInTime,
    this.checkInLatitude,
    this.checkInLongitude,
    this.status,
  });

  factory CheckInDataModel.fromJson(Map<String, dynamic> json) {
    return CheckInDataModel(
      checkInTime: json['check_in_time'],
      checkInLatitude: json['latitude'],
      checkInLongitude: json['longitude'],
      status: json['status'],
    );
  }


}

class CheckOutDataModel {
  String? checkOutTime;
  String? checkOutLatitude;
  String? checkOutLongitude;
  String? status;

  CheckOutDataModel({
    this.checkOutTime,
    this.checkOutLatitude,
    this.checkOutLongitude,
    this.status,
  });

  factory CheckOutDataModel.fromJson(Map<String, dynamic> json) {
    return CheckOutDataModel(
      checkOutTime: json['check_out_time'],
      checkOutLatitude: json['latitude'],
      checkOutLongitude: json['longitude'],
      status: json['status'],
    );
  }

}

class AttendancesHistoryPathRequest {
  String month;
  String year;
  String token;

  AttendancesHistoryPathRequest({
    required this.month,
    required this.year,
    required this.token,
  });

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'year': year,
      'token': token,
    };
  }
}