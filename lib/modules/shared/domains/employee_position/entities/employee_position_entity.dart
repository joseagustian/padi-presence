
class EmployeePositions {
  int status;
  List<PositionData> data;
  String message;

  EmployeePositions({
    required this.status,
    required this.data,
    required this.message,
  });
}

class PositionData {
  String id;
  String positionName;

  PositionData({
    required this.id,
    required this.positionName,
  });
}