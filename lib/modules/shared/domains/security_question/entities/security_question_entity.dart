
class SecurityQuestions {
  int status;
  List<QuestionData> data;
  String message;

  SecurityQuestions({
    required this.status,
    required this.data,
    required this.message,
  });

}

class QuestionData {
  String id;
  String question;

  QuestionData({
    required this.id,
    required this.question,
  });

}