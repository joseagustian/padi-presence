
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/modules/shared/presenters/location/office/office_location_provider.dart';
import 'package:padi/modules/shared/presenters/location/user/user_location_provider.dart';

class OfficeDistance {

  final OfficeLocationProvider _officeLocationProvider = OfficeLocationProvider();
  final UserLocationProvider _userLocationProvider = UserLocationProvider();

  Future<double> getDistance() async {
    final officeLocation = await _officeLocationProvider.getOfficeLocation();
    final userLocation = await _userLocationProvider.getLocation();

    final double officeLatitude = officeLocation['latitude']!;
    final double officeLongitude = officeLocation['longitude']!;

    final double userLatitude = userLocation.latitude;
    final double userLongitude = userLocation.longitude;

    const earthRadius = 6378.1370;

    final double officeLatRadians = officeLatitude * (pi / 180);
    final double officeLongRadians = officeLongitude * (pi / 180);
    final double userLatRadians = userLatitude * (pi / 180);
    final double userLongRadians = userLongitude * (pi / 180);

    final double longDiff = userLongRadians - officeLongRadians;
    final double latDiff = userLatRadians - officeLatRadians;

    final double a = pow(sin(latDiff / 2), 2) +
        cos(officeLatRadians) *
            cos(userLatRadians) *
            pow(sin(longDiff / 2), 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final double distance = earthRadius * c;

    return distance;
  }


}

final getOfficeDistanceProvider = Provider.autoDispose<OfficeDistance>((ref) {
  return OfficeDistance();
});

final officeDistanceProvider = FutureProvider.autoDispose<double>((ref) async {
  final data = await ref.watch(getOfficeDistanceProvider).getDistance();
  return data;
});