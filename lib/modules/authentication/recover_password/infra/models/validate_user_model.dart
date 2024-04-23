class ValidateUserModel {
  int status;
  dynamic data;
  String message;

  ValidateUserModel({
    required this.status,
    this.data,
    required this.message
  });

  factory ValidateUserModel.fromJson(Map<String, dynamic> json) {
    return ValidateUserModel(
      status: json['status'],
      data: json['data'],
      message: json['message']
    );
  }
}

class ValidateUserBodyRequest {
  final String email;
  final String question;
  final String answer;

  ValidateUserBodyRequest({
    required this.email,
    required this.question,
    required this.answer
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "question": question,
      "question_answer": answer
    };
  }
}