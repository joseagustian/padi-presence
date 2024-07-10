import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/modules/shared/domains/all_office_location/entities/all_office_location_entity.dart';

import '../../../domains/all_office_location/usecases/all_office_location_usecase.dart';
import '../../../infra/sources/all_office_location_service.dart';

final allOfficeLocationServiceProvider = Provider<AllOfficeLocationService>((ref) {
  return AllOfficeLocationService();
});

final allOfficeLocationUseCaseProvider = Provider<AllOfficeLocationUseCase>((ref) {
  final allOfficeLocationService = ref.watch(allOfficeLocationServiceProvider);
  return AllOfficeLocationUseCase(allOfficeLocationService);
});

final getAllOfficeLocationProvider = Provider<AllOfficeLocationProvider>((ref) {
  final allOfficeLocationUseCase = ref.watch(allOfficeLocationUseCaseProvider);
  return AllOfficeLocationProvider(allOfficeLocationUseCase);
});

final allOfficeLocationProvider = FutureProvider.autoDispose<AllOfficeLocation>((ref) async {
  final allOfficeLocationProvider = ref.watch(getAllOfficeLocationProvider);
  return allOfficeLocationProvider.getAllOfficeLocation();
});


class AllOfficeLocationProvider {
  final AllOfficeLocationUseCase allOfficeLocationUseCase;

  AllOfficeLocationProvider(this.allOfficeLocationUseCase);

  bool isLoading = false;
  String? error;

  AllOfficeLocation? response;

  Future<AllOfficeLocation> getAllOfficeLocation() async {
    isLoading = true;

    try {
      response = await allOfficeLocationUseCase.getAllOfficeLocation();
      isLoading = false;
      return response!;
    } on Exception catch (e) {
      if (e.toString().contains('SocketException')) {
        error = 'No Internet Connection';
      } else if (e.toString().contains('TimeoutException')) {
        error = 'Failed to connect to server';
      } else {
        error = e.toString();
      }
      throw Exception(error);
    }
  }
}