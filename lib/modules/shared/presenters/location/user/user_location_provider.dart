import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class UserLocationProvider {
  Future<Position> getLocation() async {


    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
    );
  }

  Future<Map<String, dynamic>> getUserCoordinate() async {
    final coordinates = await getLocation();
    return {
      'latitude': coordinates.latitude,
      'longitude': coordinates.longitude,
    };
  }

  Future<String> getLocationName() async {
    final coordinates = await getLocation();
    final locationName = await placemarkFromCoordinates(
        coordinates.latitude,
        coordinates.longitude
    );
    return locationName[0].subLocality.toString();
  }

  Future<String> getLocationDetail() async {
    final coordinates = await getLocation();
    final locationName = await placemarkFromCoordinates(
        coordinates.latitude,
        coordinates.longitude
    );
    return '${locationName[0].thoroughfare}, ${locationName[0].subLocality}, ${locationName[0].locality}, ${locationName[0].administrativeArea}';
  }

}

final getUserLocationProvider = Provider.autoDispose<UserLocationProvider>((ref) {
  return UserLocationProvider();
});

final userLocationProvider = FutureProvider.autoDispose<Position>((ref) {
  return ref.watch(getUserLocationProvider).getLocation();
});