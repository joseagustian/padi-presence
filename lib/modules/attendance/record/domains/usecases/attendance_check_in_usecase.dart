
import 'package:padi/modules/attendance/record/domains/entities/attendance_check_in_entity.dart';
import 'package:padi/modules/attendance/record/infra/models/attendance_check_in_model.dart';
import 'package:padi/modules/attendance/record/infra/sources/attendance_check_in_services.dart';

class AttendanceCheckInUseCase {

  final AttendanceCheckInServices attendanceCheckInServices;

  AttendanceCheckInUseCase(this.attendanceCheckInServices);

  Future<AttendanceCheckIn> checkIn(CheckInBodyRequest body) async {
    final response = await attendanceCheckInServices.checkIn(body);

    final responses = AttendanceCheckIn(
        status: response.status,
        data: response.data,
        message: response.message,
    );

    return responses;

  }

}