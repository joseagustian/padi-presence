import 'package:padi/modules/attendance/record/domains/entities/attendance_by_id_entity.dart';

import '../../../../../core/utils/date_time_formatter.dart';
import '../../infra/sources/attendance_by_id_services.dart';

class AttendanceDataByIDUseCase {

  final AttendanceDataByIDServices attendanceDataByIDServices;

  AttendanceDataByIDUseCase(this.attendanceDataByIDServices);

  Future<AttendanceDataById> getAttendanceDetailByID(String attendanceId) async {
    final response = await attendanceDataByIDServices.getAttendanceDataByID(attendanceId);

    final responses = AttendanceDataById(
      status: response.status,
      data: response.data.map((e) => AttendanceDetailDataByID(
        attendanceId: e.attendanceId,
        checkIn: CheckInData(
          checkInTime: e.checkIn?.checkInTime,
          checkInLatitude: e.checkIn?.checkInLatitude,
          checkInLongitude: e.checkIn?.checkInLongitude,
          status: e.checkIn?.status,
        ),
        checkOut: CheckOutData(
          checkOutTime: e.checkOut?.checkOutTime,
          checkOutLatitude: e.checkOut?.checkOutLatitude,
          checkOutLongitude: e.checkOut?.checkOutLongitude,
          status: e.checkOut?.status,
        ),
        note: e.note,
        activity: e.activity,
        workType: e.workType,
        workingHours: formatWorkingHours(e.workingHours),
        scheduleIn: e.scheduleIn,
        scheduleOut: e.scheduleOut,
      )).toList(),
      message: response.message,
    );

    return responses;
  }

}