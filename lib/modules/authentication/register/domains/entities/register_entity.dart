class Register {
  int status;
  dynamic data;
  String message;

  Register({
    required this.status,
    this.data,
    required this.message
  });
}