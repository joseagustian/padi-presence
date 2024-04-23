
class SecurityQuestionsModel {
  int status;
  List<QuestionData> data;
  String message;

  SecurityQuestionsModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory SecurityQuestionsModel.fromJson(Map<String, dynamic> json) {
    return SecurityQuestionsModel(
      status: json['status'],
      data: List<QuestionData>.from(json['data'].map((x) => QuestionData.fromJson(x))),
      message: json['message'],
    );
  }

}

class QuestionData {
  String id;
  String question;

  QuestionData({
    required this.id,
    required this.question,
  });

  factory QuestionData.fromJson(Map<String, dynamic> json) {
    return QuestionData(
      id: json['id'],
      question: json['question'],
    );
  }

}
