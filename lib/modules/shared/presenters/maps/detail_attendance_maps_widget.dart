import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:padi/core/constants/constant.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/shared/presenters/maps/pulse_circle_marker.dart';

class DetailAttendanceMapsWidget extends StatelessWidget {
  final double height;
  final double? lat;
  final double? long;
  const DetailAttendanceMapsWidget({
    super.key,
    required this.height,
    this.lat,
    this.long
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: AbsorbPointer(
        child: lat != null && long != null ? FlutterMap(
          options: MapOptions(
              initialZoom: 15.5,
              initialCenter: LatLng(lat!, long!)
          ),
          mapController: MapController(),
          children: [
            TileLayer(
              urlTemplate: TILE_MAP_URL,
              userAgentPackageName: Strings.appAgentPackageName,
            ),
            CircleLayer(
              circles: [
                CircleMarker(
                    point: LatLng(lat!, long!),
                    radius: 100,
                    useRadiusInMeter: true,
                    color: const Color.fromARGB(150, 152, 205, 248)
                )
              ],
            ),
            MarkerLayer(
              markers: [
                Marker(
                    point: LatLng(lat!, long!),
                    child: const PulseCircleMarker()
                )
              ],
            ),
          ],
        ) : Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
          ),
        )
      ),
    );
  }
}
