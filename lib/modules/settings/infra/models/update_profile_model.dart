
class UpdateProfileModel {

  int status;
  dynamic data;
  String message;

  UpdateProfileModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(
    status: json['status'],
    data: json['data'],
    message: json['message'],
  );

}

class UpdateProfileBodyRequest {
  String fullName;
  String dateOfBirth;
  String employeeId;
  String address;
  String religion;

  UpdateProfileBodyRequest({
    required this.fullName,
    required this.dateOfBirth,
    required this.employeeId,
    required this.address,
    required this.religion,
  });

  Map<String, dynamic> toJson() => {
    "full_name": fullName,
    "date_of_birth": dateOfBirth,
    "nip": employeeId,
    "address": address,
    "religion": religion,
  };
}