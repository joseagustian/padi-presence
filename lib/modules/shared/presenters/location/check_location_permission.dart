
import 'package:geolocator/geolocator.dart';
import 'package:padi/core/utils/app_logger.dart';


enum LocationPermissionStatus {
  locationServiceDisabled,
  permissionDenied,
  permissionDeniedForever,
  permissionGranted,
}

Future<LocationPermissionStatus> checkLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  AppLogger logger = AppLogger();

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    logger.recordLog(LoggerMessage.locationServiceDisabled, LogType.warning);
    return LocationPermissionStatus.locationServiceDisabled;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    return LocationPermissionStatus.permissionDenied;
  }

  if (permission == LocationPermission.deniedForever) {
    return LocationPermissionStatus.permissionDeniedForever;
  }

  return LocationPermissionStatus.permissionGranted;
}