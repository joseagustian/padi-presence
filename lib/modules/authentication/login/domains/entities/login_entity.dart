class Login {
  int? status;
  LoginData? data;
  String? token;
  String? message;

  Login({
    required this.status,
    required this.data,
    required this.token,
    required this.message,
  });
}

class LoginData {
  String? id;
  String? email;
  String? password;
  String? accessCode;
  String? reminder;
  String? status;
  String? name;
  String? nip;
  String? dateOfBirth;
  String? address;
  String? religion;
  String? positionName;
  String? divisionName;
  double? officeLat;
  double? officeLong;

  String? onProgressAttendanceId;

  LoginData({
    required this.id,
    required this.email,
    required this.password,
    required this.accessCode,
    required this.reminder,
    required this.status,
    required this.name,
    required this.nip,
    required this.dateOfBirth,
    required this.address,
    required this.religion,
    required this.positionName,
    required this.divisionName,
    required this.officeLat,
    required this.officeLong,
    required this.onProgressAttendanceId,
  });
}
