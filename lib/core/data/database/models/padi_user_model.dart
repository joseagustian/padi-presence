
class PadiUserAccountModel {
  String? userId;
  String? userEmail;
  String? userAccountName;
  String? userEmployeeId;
  String? userDateOfBirth;
  String? userAddress;
  String? userReligion;
  String? userJobPosition;
  String? userJobDivision;
  String? userAccessToken;
  String? userOfficeLat;
  String? userOfficeLong;
  String? onProgressAttendanceId;

  PadiUserAccountModel({
    this.userId,
    this.userEmail,
    this.userAccountName,
    this.userEmployeeId,
    this.userDateOfBirth,
    this.userAddress,
    this.userReligion,
    this.userJobPosition,
    this.userJobDivision,
    this.userAccessToken,
    this.userOfficeLat,
    this.userOfficeLong,
    this.onProgressAttendanceId,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'user_email': userEmail,
      'user_account_name': userAccountName,
      'user_employee_id': userEmployeeId,
      'user_date_of_birth': userDateOfBirth,
      'user_address': userAddress,
      'user_religion': userReligion,
      'user_job_position': userJobPosition,
      'user_job_division': userJobDivision,
      'user_access_token': userAccessToken,
      'user_office_lat': userOfficeLat,
      'user_office_long': userOfficeLong,
      'on_progress_attendance_id': onProgressAttendanceId,
    };
  }

  factory PadiUserAccountModel.fromMap(Map<String, dynamic> map) {
    return PadiUserAccountModel(
      userId: map['user_id'],
      userEmail: map['user_email'],
      userAccountName: map['user_account_name'],
      userEmployeeId: map['user_employee_id'],
      userDateOfBirth: map['user_date_of_birth'],
      userAddress: map['user_address'],
      userReligion: map['user_religion'],
      userJobPosition: map['user_job_position'],
      userJobDivision: map['user_job_division'],
      userAccessToken: map['user_access_token'],
      userOfficeLat: map['user_office_lat'],
      userOfficeLong: map['user_office_long'],
      onProgressAttendanceId: map['on_progress_attendance_id'],
    );
  }

}