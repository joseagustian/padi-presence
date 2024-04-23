
import 'package:padi/core/utils/date_time_formatter.dart';
import 'package:padi/modules/attendance/record/domains/entities/attendance_history_entity.dart';
import 'package:padi/modules/attendance/record/infra/sources/attendance_history_services.dart';

class AttendancesHistoryUseCase {

  final AttendancesHistoryServices attendanceHistoryServices;

  AttendancesHistoryUseCase(this.attendanceHistoryServices);

  Future<AttendancesHistory> getAttendancesHistory() async {
    final response = await attendanceHistoryServices.getAttendanceHistory();

    final responses = AttendancesHistory(
        status: response.status,
        data: response.data?.map((e) => AttendanceHistoryData(
          attendanceId: e.attendanceId ?? '',
          checkIn: CheckInData(
            checkInTime: e.checkIn?.checkInTime ?? '',
            checkInDate: getDateFromAttendanceTime(e.checkIn?.checkInTime ?? ''),
            checkInDay: getDayFromAttendanceTime(e.checkIn?.checkInTime ?? ''),
            checkInClock: getTimeFromAttendanceTime(e.checkIn?.checkInTime ?? ''),
            checkInLatitude: e.checkIn?.checkInLatitude ?? '',
            checkInLongitude: e.checkIn?.checkInLongitude ?? '',
            status: e.checkIn?.status ?? '',
          ),
          checkOut: CheckOutData(
            checkOutTime: e.checkOut?.checkOutTime ?? '',
            checkOutDate: getDateFromAttendanceTime(e.checkOut?.checkOutTime ?? ''),
            checkOutDay: getDayFromAttendanceTime(e.checkOut?.checkOutTime ?? ''),
            checkOutClock: getTimeFromAttendanceTime(e.checkOut?.checkOutTime ?? ''),
            checkOutLatitude: e.checkOut?.checkOutLatitude ?? '',
            checkOutLongitude: e.checkOut?.checkOutLongitude ?? '',
            status: e.checkOut?.status ?? '',
          ),
          note: e.note ?? '',
          activity: e.activity ?? '',
          workType: e.workType ?? '',
          workingHours: formatWorkingHours(e.workingHours ?? ''),
          attendanceDate: getDateFromAttendanceTime(e.attendanceDate ?? ''),
          attendanceDay: getDayFromAttendanceTime(e.attendanceDate ?? ''),
          dayOff: e.dayOff ?? '',
        )).toList(),
        message: response.message,
    );

    return responses;
  }

}