
class LogoutModel {
  int status;
  dynamic data;
  String message;

  LogoutModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
    status: json['status'],
    data: json['data'],
    message: json['message'],
  );

}