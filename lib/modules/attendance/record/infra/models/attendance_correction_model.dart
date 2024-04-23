class AttendanceCorrectionModel {
  int status;
  String message;

  AttendanceCorrectionModel({
    required this.status,
    required this.message,
  });

  factory AttendanceCorrectionModel.fromJson(Map<String, dynamic> json) => AttendanceCorrectionModel(
    status: json["status"],
    message: json["message"],
  );
}

class AttendanceCorrectionBody {
  String note;
  String activity;

  AttendanceCorrectionBody({
    required this.note,
    required this.activity,
  });

  Map<String, dynamic> toJson() => {
    "note": note,
    "activity": activity,
  };
}