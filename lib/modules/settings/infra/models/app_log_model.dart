
class ApplicationLogsModel {
  List<ApplicationLogDataModel> data;

  ApplicationLogsModel({
    required this.data,
  });

  factory ApplicationLogsModel.fromJson(Map<String, dynamic> json) {
    return ApplicationLogsModel(
      data: List<ApplicationLogDataModel>.from(json["data"].map((x) => ApplicationLogDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "logs": List<dynamic>.from(data.map((x) => x.toJson())),
  };

}

class ApplicationLogDataModel {
  String logId;
  String time;
  String log;
  String type;

  ApplicationLogDataModel({
    required this.logId,
    required this.time,
    required this.log,
    required this.type,
  });

  factory ApplicationLogDataModel.fromJson(Map<String, dynamic> json) {
    return ApplicationLogDataModel(
      logId: json["logId"],
      time: json["time"],
      log: json["log"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() => {
    "logId": logId,
    "time": time,
    "log": log,
    "type": type,
  };
}