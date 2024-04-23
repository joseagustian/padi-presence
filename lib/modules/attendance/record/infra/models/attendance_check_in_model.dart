
class AttendanceCheckInModel {
  int status;
  dynamic data;
  String message;

  AttendanceCheckInModel({
    required this.status,
    required this.data,
    required this.message
  });

  factory AttendanceCheckInModel.fromJson(Map<String, dynamic> json) {
    return AttendanceCheckInModel(
      status: json['status'],
      data: json['data'],
      message: json['message']
    );
  }

}

class CheckInBodyRequest {
  String checkInTime;
  String latitude;
  String longitude;
  String status;
  String workType;

  CheckInBodyRequest({
    required this.checkInTime,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.workType
  });

  Map<String, dynamic> toJson() {
    return {
      'check_in_time': checkInTime,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
      'work_type': workType
    };
  }
}

