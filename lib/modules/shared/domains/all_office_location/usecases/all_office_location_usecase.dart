import 'package:padi/modules/shared/domains/all_office_location/entities/all_office_location_entity.dart';

import '../../../infra/sources/all_office_location_service.dart';

class AllOfficeLocationUseCase {
  final AllOfficeLocationService allOfficeLocationService;

  AllOfficeLocationUseCase(this.allOfficeLocationService);

  Future<AllOfficeLocation> getAllOfficeLocation() async {
    final allOfficeLocationData = await allOfficeLocationService.getAllOfficeLocation();

    final allOfficeLocation = AllOfficeLocation(
      status: allOfficeLocationData.status,
      data: allOfficeLocationData.data.map((e) => OfficeLocationData(
        id: e.id,
        officeName: e.officeName,
        longitude: e.longitude,
        latitude: e.latitude,
        createdAt: e.createdAt,
      )).toList(),
      message: allOfficeLocationData.message,
    );

    return allOfficeLocation;
  }
}