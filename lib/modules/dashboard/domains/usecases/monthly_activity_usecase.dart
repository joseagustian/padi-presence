
import 'package:padi/modules/dashboard/domains/entities/monthly_activity_entity.dart';
import 'package:padi/modules/dashboard/infra/sources/monthly_activity_services.dart';

class MonthlyActivityUseCase {

  final MonthlyActivityServices monthlyActivityServices;
  MonthlyActivityUseCase(this.monthlyActivityServices);

  Future<MonthlyActivity> getMonthlyActivity() async {
    final response = await monthlyActivityServices.getMonthlyActivity();

    final responses = MonthlyActivity(
      status: response.status,
      data: MonthlyActivityData(
        totalWorkingDay: response.data.totalWorkingDay,
        employeeWorkingDay: response.data.employeeWorkingDay,
        totalWorkingHour: response.data.totalWorkingHour,
        employeeWorkingHour: response.data.employeeWorkingHour,
        notPresent: response.data.notPresent,
        wfh: response.data.workFromHome,
        wfo: response.data.workFromOffice,
        late: response.data.late,
      ),
      message: response.message,
    );

    return responses;
  }

}