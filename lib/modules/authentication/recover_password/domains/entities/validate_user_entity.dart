
class ValidateUser {
  int status;
  dynamic data;
  String message;

  ValidateUser({
    required this.status,
    this.data,
    required this.message,
  });
}