import 'package:padi/modules/attendance/record/domains/entities/attendance_correction_entity.dart';
import 'package:padi/modules/attendance/record/infra/models/attendance_correction_model.dart';
import 'package:padi/modules/attendance/record/infra/sources/attendance_correction_services.dart';

class AttendanceCorrectionUseCase {
  final AttendanceCorrectionServices attendanceCorrectionServices;

  AttendanceCorrectionUseCase(this.attendanceCorrectionServices);

  Future<AttendanceCorrection> attendanceCorrection(AttendanceCorrectionBody body, String? attendanceId) async {
    final response = await attendanceCorrectionServices.attendanceCorrection(body, attendanceId);

    final responses = AttendanceCorrection(
      status: response.status,
      message: response.message,
    );

    return responses;
  }
}