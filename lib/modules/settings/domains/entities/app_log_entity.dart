
class ApplicationLogs {
  List<ApplicationLogData> logs;
  ApplicationLogs({
    required this.logs,
  });
}

class ApplicationLogData {
  String logId;
  String time;
  String log;
  String type;


  ApplicationLogData({
    required this.logId,
    required this.time,
    required this.log,
    required this.type,
  });
}