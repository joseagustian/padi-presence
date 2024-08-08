class CreateSubmissionModel {
  int status;
  String message;

  CreateSubmissionModel({
    required this.status,
    required this.message,
  });

  factory CreateSubmissionModel.fromJson(Map<String, dynamic> json) => CreateSubmissionModel(
    status: json['status'],
    message: json['message'],
  );
}

class CreateSubmissionBodyRequest {
  String submissionType;
  String startDate;
  String endDate;
  String description;

  CreateSubmissionBodyRequest({
    required this.submissionType,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    "status": submissionType,
    "start_date": startDate,
    "end_date": endDate,
    "reason": description,
  };
}