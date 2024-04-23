class EmployeePositionsModel {
  int status;
  List<PositionData> data;
  String message;

  EmployeePositionsModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory EmployeePositionsModel.fromJson(Map<String, dynamic> json) {
    return EmployeePositionsModel(
      status: json['status'],
      data: List<PositionData>.from(json['data'].map((x) => PositionData.fromJson(x))),
      message: json['message'],
    );
  }

}

class PositionData {
  String id;
  String positionName;

  PositionData({
    required this.id,
    required this.positionName,
  });

  factory PositionData.fromJson(Map<String, dynamic> json) {
    return PositionData(
      id: json['id'],
      positionName: json['position_name'],
    );
  }
}