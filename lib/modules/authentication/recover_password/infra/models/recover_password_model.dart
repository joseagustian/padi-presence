class RecoverPasswordModel {
  int status;
  String message;

  RecoverPasswordModel({
    required this.status,
    required this.message
  });

  factory RecoverPasswordModel.fromJson(Map<String, dynamic> json) {
    return RecoverPasswordModel(
      status: json['status'],
      message: json['message']
    );
  }
}

class RecoverPasswordBodyRequest {
  final String email;
  final String newPassword;

  RecoverPasswordBodyRequest({
    required this.email,
    required this.newPassword
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "new_password": newPassword
    };
  }
}