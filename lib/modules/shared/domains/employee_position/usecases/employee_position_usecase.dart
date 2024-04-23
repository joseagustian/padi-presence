import 'package:padi/modules/shared/domains/employee_position/entities/employee_position_entity.dart';
import 'package:padi/modules/shared/infra/sources/employee_position_service.dart';

class EmployeePositionUseCase {
  final EmployeePositionServices employeePositionServices;

  EmployeePositionUseCase(this.employeePositionServices);

  Future<EmployeePositions> getEmployeePositions(String divisionId) async {
    final employeePositionData = await employeePositionServices.getEmployeePositions(divisionId);

    final employeePosition = EmployeePositions(
      status: employeePositionData.status,
      data: employeePositionData.data.map((e) => PositionData(
        id: e.id,
        positionName: e.positionName,
      )).toList(),
      message: employeePositionData.message,
    );

    return employeePosition;
  }
}