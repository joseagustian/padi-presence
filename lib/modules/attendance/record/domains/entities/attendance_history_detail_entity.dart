
class AttendanceHistoryDetail {
  int status;
  List<AttendanceHistoryDetailData> data;
  String message;

  AttendanceHistoryDetail({
    required this.status,
    required this.data,
    required this.message,
  });

}

class AttendanceHistoryDetailData {
  String? attendanceId;
  CheckInData? checkIn;
  CheckOutData? checkOut;
  String? note;
  String? activity;
  String? workType;
  String? workingHours;
  String? scheduleIn;
  String? scheduleOut;

  AttendanceHistoryDetailData({
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

}

class CheckInData {
  String? checkInTime;
  String? checkInLatitude;
  String? checkInLongitude;
  String? status;

  CheckInData({
    this.checkInTime,
    this.checkInLatitude,
    this.checkInLongitude,
    this.status,
  });

}

class CheckOutData {
  String? checkOutTime;
  String? checkOutLatitude;
  String? checkOutLongitude;
  String? status;

  CheckOutData({
    this.checkOutTime,
    this.checkOutLatitude,
    this.checkOutLongitude,
    this.status,
  });

}