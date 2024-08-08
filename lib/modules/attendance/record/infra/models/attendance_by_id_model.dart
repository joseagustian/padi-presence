
class AttendanceDataByIDModel {
  int status;
  List<AttendanceDetailDataByID> data;
  String message;

  AttendanceDataByIDModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory AttendanceDataByIDModel.fromJson(Map<String, dynamic> json) {
    return AttendanceDataByIDModel(
      status: json['status'],
      data: json['data'] != null ? (json['data'] as List).map((i) => AttendanceDetailDataByID.fromJson(i)).toList() : [],
      message: json['message'],
    );
  }
}

class AttendanceDetailDataByID {
  String? attendanceId;
  CheckInDataModel? checkIn;
  CheckOutDataModel? checkOut;
  String? note;
  String? activity;
  String? workType;
  String? workingHours;
  String? scheduleIn;
  String? scheduleOut;

  AttendanceDetailDataByID({
    this.attendanceId,
    this.checkIn,
    this.checkOut,
    this.note,
    this.activity,
    this.workType,
    this.workingHours,
    this.scheduleIn,
    this.scheduleOut,
  });

  factory AttendanceDetailDataByID.fromJson(Map<String, dynamic> json) {
    return AttendanceDetailDataByID(
      attendanceId: json['transaction_id'],
      checkIn: json['checkin'] != null ? CheckInDataModel.fromJson(json['checkin']) : null,
      checkOut: json['checkout'] != null ? CheckOutDataModel.fromJson(json['checkout']) : null,
      note: json['note'],
      activity: json['activity'],
      workType: json['work_type'],
      workingHours: json['working_hours'],
      scheduleIn: json['schedule_in'],
      scheduleOut: json['schedule_out'],
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