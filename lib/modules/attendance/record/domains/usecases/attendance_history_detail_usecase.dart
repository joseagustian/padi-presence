
import 'package:padi/core/utils/date_time_formatter.dart';
import 'package:padi/modules/attendance/record/domains/entities/attendance_history_detail_entity.dart';
import 'package:padi/modules/attendance/record/infra/sources/attendance_history_detail_services.dart';

class AttendanceHistoryDetailUseCase {

  final AttendanceHistoryDetailServices attendancesHistoryDetailServices;

  AttendanceHistoryDetailUseCase(this.attendancesHistoryDetailServices);

  Future<AttendanceHistoryDetail> getAttendanceHistoryDetail(String attendanceId) async {
    final response = await attendancesHistoryDetailServices.getAttendanceHistoryDetail(attendanceId);

    final responses = AttendanceHistoryDetail(
      status: response.status,
      data: response.data.map((e) => AttendanceHistoryDetailData(
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