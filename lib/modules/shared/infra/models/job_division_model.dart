class JobDivisionsModel {
  int status;
  List<DivisionData> data;
  String message;

  JobDivisionsModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory JobDivisionsModel.fromJson(Map<String, dynamic> json) {
    return JobDivisionsModel(
      status: json['status'],
      data: List<DivisionData>.from(json['data'].map((x) => DivisionData.fromJson(x))),
      message: json['message'],
    );
  }

}

class DivisionData {
  String id;
  String divisionName;

  DivisionData({
    required this.id,
    required this.divisionName,
  });

  factory DivisionData.fromJson(Map<String, dynamic> json) {
    return DivisionData(
      id: json['id'],
      divisionName: json['division_name'],
    );
  }
}