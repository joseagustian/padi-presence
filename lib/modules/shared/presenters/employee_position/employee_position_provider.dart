import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/shared/domains/employee_position/entities/employee_position_entity.dart';
import 'package:padi/modules/shared/domains/employee_position/usecases/employee_position_usecase.dart';
import 'package:padi/modules/shared/infra/sources/employee_position_service.dart';

final employeePositionServicesProvider = Provider<EmployeePositionServices>((ref) {
  return EmployeePositionServices();
});

final employeePositionUseCaseProvider = Provider<EmployeePositionUseCase>((ref) {
  final employeePositionServices = ref.watch(employeePositionServicesProvider);
  return EmployeePositionUseCase(employeePositionServices);
});

final getEmployeePositionProvider = Provider<EmployeePositionProvider>((ref) {
  final employeePositionUseCase = ref.watch(employeePositionUseCaseProvider);
  return EmployeePositionProvider(employeePositionUseCase);
});

final employeePositionProvider = FutureProvider.autoDispose.family<EmployeePositions, String>((ref, divisionId) async {
  final employeePositionProvider = ref.watch(getEmployeePositionProvider);
  return employeePositionProvider.getEmployeePositions(divisionId);
});

class EmployeePositionProvider {
  final EmployeePositionUseCase employeePositionUseCase;

  EmployeePositionProvider(this.employeePositionUseCase);

  bool isLoading = false;
  String? error;

  EmployeePositions? response;

  Future<EmployeePositions> getEmployeePositions(String divisionId) async {

    isLoading = true;

    try {
      response = await employeePositionUseCase.getEmployeePositions(divisionId);
      isLoading = false;
      return response!;
    } on Exception catch (e) {
      if (e.toString().contains('SocketException')) {
        error = Strings.noInternetConnection;
      } else if (e.toString().contains('TimeoutException')) {
        error = Strings.failToConnectToServer;
      } else {
        error = e.toString();
      }
      throw Exception(error);
    }
  }

}