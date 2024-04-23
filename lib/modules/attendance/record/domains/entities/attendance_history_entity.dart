
class AttendancesHistory {

  int status;
  List<AttendanceHistoryData>? data;
  String message;

  AttendancesHistory({
    required this.status,
    required this.data,
    required this.message,
  });


}

class AttendanceHistoryData {
  String? attendanceId;
  CheckInData? checkIn;
  CheckOutData? checkOut;
  String? note;
  String? activity;
  String workType;
  String? workingHours;

  String? attendanceDate;
  String? attendanceDay;
  String? dayOff;

  AttendanceHistoryData({
    this.attendanceId,
    this.checkIn,
    this.checkOut,
    this.note,
    this.activity,
    required this.workType,
    this.workingHours,
    this.attendanceDate,
    this.attendanceDay,
    this.dayOff,
  });

}

class CheckInData {
  String? checkInTime;
  String? checkInDate;
  String? checkInDay;
  String? checkInClock;
  String? checkInLatitude;
  String? checkInLongitude;
  String? status;

  CheckInData({
    this.checkInTime,
    this.checkInDate,
    this.checkInDay,
    this.checkInClock,
    this.checkInLatitude,
    this.checkInLongitude,
    this.status,
  });

}

class CheckOutData {
  String? checkOutTime;
  String? checkOutDate;
  String? checkOutDay;
  String? checkOutClock;
  String? checkOutLatitude;
  String? checkOutLongitude;
  String? status;

  CheckOutData({
    this.checkOutTime,
    this.checkOutDate,
    this.checkOutDay,
    this.checkOutClock,
    this.checkOutLatitude,
    this.checkOutLongitude,
    this.status,
  });

}