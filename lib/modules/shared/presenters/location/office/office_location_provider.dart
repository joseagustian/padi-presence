
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:padi/core/data/database/repositories/padi_user_table_repository.dart';

class OfficeLocationProvider {

  final PadiUserAccountTableRepository _padiUserAccountTableRepository = PadiUserAccountTableRepository();

  Future<Map<String, double>> getOfficeLocation() async {
    final data = await _padiUserAccountTableRepository.getPadiUserAccount();
    if (data != null) {
      final latitude = double.tryParse(data.userOfficeLat ?? '');
      final longitude = double.tryParse(data.userOfficeLong ?? '');
      return {
        'latitude': latitude ?? 0.0,
        'longitude': longitude ?? 0.0,
      };
    } else {
      return {
        'latitude': 0.0,
        'longitude': 0.0,
      };
    }
  }

  Future<String> getOfficeLocationName() async {
    final data = await _padiUserAccountTableRepository.getPadiUserAccount();
    if (data != null) {
      final officeLocationName = await placemarkFromCoordinates(
          data.userOfficeLat as double, data.userOfficeLong as double
      );
      return officeLocationName[0].subLocality.toString();
    } else {
      return '';
    }
  }

  Future<String> getOfficeLocationDetail() async {
    final data = await _padiUserAccountTableRepository.getPadiUserAccount();
    if (data != null) {
      final officeLocationName = await placemarkFromCoordinates(
          data.userOfficeLat as double, data.userOfficeLong as double
      );
      return '${officeLocationName[0].thoroughfare}, ${officeLocationName[0].subLocality}, ${officeLocationName[0].locality}, ${officeLocationName[0].administrativeArea}';
    } else {
      return '';
    }
  }

}

final officeLocationProvider = Provider.autoDispose<OfficeLocationProvider>((ref) {
  return OfficeLocationProvider();
});

final officeCoordinatesProvider = FutureProvider.autoDispose<Map<String, double>>((ref) async {
  final data = await ref.watch(officeLocationProvider).getOfficeLocation();
  return data;
});