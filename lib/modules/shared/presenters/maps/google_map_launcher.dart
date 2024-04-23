
import 'package:map_launcher/map_launcher.dart';

class GoogleMapLauncher {
  GoogleMapLauncher._();

  static Future<void> launch(double latitude, double longitude, String title) async {
    final availableMaps = await MapLauncher.installedMaps;

    await availableMaps.first.showMarker(
      coords: Coords(latitude, longitude),
      title: title,
    );
  }
}