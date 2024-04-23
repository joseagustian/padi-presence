
import 'package:padi/modules/attendance/record/domains/entities/attendance_check_out_entity.dart';
import 'package:padi/modules/attendance/record/infra/models/attendance_check_out_model.dart';
import 'package:padi/modules/attendance/record/infra/sources/attendance_check_out_services.dart';

class AttendanceCheckOutUseCase {
  final AttendanceCheckOutServices attendanceCheckOutServices;

  AttendanceCheckOutUseCase(this.attendanceCheckOutServices);

  Future<AttendanceCheckOut> checkOut(CheckOutBodyRequest body, String? attendanceId) async {
    final response = await attendanceCheckOutServices.checkOut(body, attendanceId);

    final responses = AttendanceCheckOut(
      status: response.status,
      message: response.message,
    );

    return responses;
  }

}