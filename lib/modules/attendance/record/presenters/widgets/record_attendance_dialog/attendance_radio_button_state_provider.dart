
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AttendanceWorkType {
  wfo,
  wfh,
  none
}

enum AttendanceWorkProgressType {
  progress,
  finished,
  none
}

final attendanceWorkTypeProvider = StateProvider.autoDispose<AttendanceWorkType>((ref) => AttendanceWorkType.none);
final attendanceWorkProgressTypeProvider = StateProvider.autoDispose<AttendanceWorkProgressType>((ref) => AttendanceWorkProgressType.none);