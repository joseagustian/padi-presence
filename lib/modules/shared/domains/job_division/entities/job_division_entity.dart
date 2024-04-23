
class JobDivisions {
  int status;
  List<DivisionData> data;
  String message;

  JobDivisions({
    required this.status,
    required this.data,
    required this.message,
  });
}

class DivisionData {
  String id;
  String divisionName;

  DivisionData({
    required this.id,
    required this.divisionName,
  });
}