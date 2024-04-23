import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:padi/core/constants/constant.dart';
import 'package:padi/core/constants/strings.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/location_radius_warning_card.dart';
import 'package:padi/modules/shared/animations/shimmer_animation.dart';
import 'package:padi/modules/shared/presenters/location/office/office_distance_provider.dart';
import 'package:padi/modules/shared/presenters/location/office/office_location_provider.dart';
import 'package:padi/modules/shared/presenters/location/user/user_location_provider.dart';
import 'package:padi/modules/shared/presenters/location/user/user_location_state_provider.dart';
import 'package:padi/modules/shared/presenters/maps/pulse_circle_marker.dart';

enum AttendanceType {
  checkIn,
  checkOut
}

class AttendanceMapsWidget extends ConsumerWidget {
  final double width;
  final double height;
  final AttendanceType type;
  const AttendanceMapsWidget({
    required this.width,
    required this.height,
    required this.type,
    super.key
  });

  @override
  Widget build(BuildContext context, ref) {

    final distance = ref.watch(officeDistanceProvider);
    final officeCoordinate = ref.watch(officeCoordinatesProvider);


    ref.watch(userLocationStateProvider.notifier);
    return SizedBox(
      width: width,
      height: height,
      child: ref.watch(userLocationProvider).when(
          data: (data) => AbsorbPointer(
            child: FlutterMap(
                options: MapOptions(
                    initialZoom: 15.5,
                    initialCenter: LatLng(data.latitude, data.longitude)
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
                          point: LatLng(officeCoordinate.value?['latitude'] ?? 0.0, officeCoordinate.value?['longitude'] ?? 0.0),
                          radius: 200,
                          useRadiusInMeter: true,
                          color: const Color.fromARGB(100, 170, 248, 152)
                      ),
                      CircleMarker(
                          point: LatLng(data.latitude, data.longitude),
                          radius: 200,
                          useRadiusInMeter: true,
                          color: const Color.fromARGB(100, 255, 229, 176)
                      ),
                    ],
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                          point: LatLng(data.latitude, data.longitude),
                          child: const PulseCircleMarker()
                      )
                    ],
                  ),
                  Visibility(
                    visible: type == AttendanceType.checkIn && distance.value != null && distance.value! >= 0.2,
                      child: const LocationRadiusWarningCard()
                  )
                ],
            ),
          ),
          error: (e, s) => Center(child: Text('$e')),
          loading: () => Shimmer(
            linearGradient: shimmerGradient,
            child: ShimmerLoading(
                isLoading: true,
                child: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                )
            )
          )
      ),
    );
  }
}
