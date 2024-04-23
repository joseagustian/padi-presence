class LoginModel {
  int? status;
  LoginDataModel? data;
  String? token;
  String? message;

  LoginModel({
    required this.status,
    required this.data,
    required this.token,
    required this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      data: LoginDataModel.fromJson(json['data']),
      token: json['token'],
      message: json['message'],
    );
  }
}

class LoginDataModel {
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

  LoginDataModel({
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

  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      accessCode: json['access_code'],
      reminder: json['reminder'],
      status: json['status'],
      name: json['name'],
      nip: json['nip'],
      dateOfBirth: json['date_of_birth'],
      address: json['address'],
      religion: json['religion'],
      positionName: json['position_name'],
      divisionName: json['division_name'],
      officeLat: json['latitude'],
      officeLong: json['longitude'],
      onProgressAttendanceId: json['transaction_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'access_code': accessCode,
      'reminder': reminder,
      'status': status,
      'name': name,
      'nip': nip,
      'date_of_birth': dateOfBirth,
      'address': address,
      'religion': religion,
      'position_name': positionName,
      'division_name': divisionName,
      'latitude': officeLat,
      'longitude': officeLong,
      'transaction_id': onProgressAttendanceId,
    };
  }

}

class LoginBodyRequest {
  String? email;
  String? password;

  LoginBodyRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
