
class AllOfficeLocation {
  int status;
  List<OfficeLocationData> data;
  String message;

  AllOfficeLocation({
    required this.status,
    required this.data,
    required this.message,
  });
}

class OfficeLocationData {
  String id;
  String officeName;
  String latitude;
  String longitude;
  String createdAt;

  OfficeLocationData({
    required this.id,
    required this.officeName,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
  });
}