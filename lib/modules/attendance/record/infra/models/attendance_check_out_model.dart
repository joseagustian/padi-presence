
class AttendanceCheckOutModel {
  int status;
  String message;

  AttendanceCheckOutModel({
    required this.status,
    required this.message
  });

  factory AttendanceCheckOutModel.fromJson(Map<String, dynamic> json) {
    return AttendanceCheckOutModel(
      status: json['status'],
      message: json['message']
    );
  }
}

class CheckOutBodyRequest {
  String checkOutTime;
  String latitude;
  String longitude;
  String status;
  String progressType;
  String activity;

  CheckOutBodyRequest({
    required this.checkOutTime,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.progressType,
    required this.activity,
  });

  Map<String, dynamic> toJson() {
    return {
      'check_out_time': checkOutTime,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
      'note': progressType,
      'activity': activity,
    };
  }

}