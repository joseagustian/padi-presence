
class RegisterModel {
  int status;
  dynamic data;
  String message;

  RegisterModel({
    required this.status,
    this.data,
    required this.message
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      status: json['status'],
      data: json['data'],
      message: json['message']
    );
  }
}

class RegisterBodyRequest {
  String fullName;
  String email;
  String securityQuestion;
  String dateOfBirth;
  String jobPosition;
  String securityQuestionAnswer;
  String password;

  RegisterBodyRequest({
    required this.fullName,
    required this.email,
    required this.securityQuestion,
    required this.dateOfBirth,
    required this.jobPosition,
    required this.securityQuestionAnswer,
    required this.password
  });

  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "email": email,
      "question": securityQuestion,
      "date_of_birth": dateOfBirth,
      "position": jobPosition,
      "reminder": securityQuestionAnswer,
      "password": password
    };
  }
}