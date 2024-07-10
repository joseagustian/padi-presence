class AllOfficeLocationModel {
  int status;
  List<OfficeLocationData> data;
  String message;

  AllOfficeLocationModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory AllOfficeLocationModel.fromJson(Map<String, dynamic> json) {
    return AllOfficeLocationModel(
      status: json['status'],
      data: List<OfficeLocationData>.from(json['data'].map((x) => OfficeLocationData.fromJson(x))),
      message: json['message'],
    );
  }
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

  factory OfficeLocationData.fromJson(Map<String, dynamic> json) {
    return OfficeLocationData(
      id: json['id'],
      officeName: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      createdAt: json['created_at'],
    );
  }
}