class PadiSchedulerModel {

  int status;
  String message;

  PadiSchedulerModel({
    required this.status,
    required this.message,
  });

  factory PadiSchedulerModel.fromJson(Map<String, dynamic> json) {
    return PadiSchedulerModel(
      status: json['status'],
      message: json['message'],
    );
  }

}