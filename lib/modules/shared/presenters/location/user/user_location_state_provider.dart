
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user_location_provider.dart';

class UserLocationState {
  String lat;
  String long;

  UserLocationState({
    required this.lat,
    required this.long,
  });

  UserLocationState copyWith({
    String? lat,
    String? long,
  }) {
    return UserLocationState(
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }
}

class UserLocationStateNotifier extends StateNotifier<UserLocationState> {

  UserLocationProvider userLocationProvider = UserLocationProvider();

  UserLocationStateNotifier() : super(UserLocationState(lat: '', long: '')) {
    if (mounted) {
      setUserCoordinates();
    }
  }

  void setUserCoordinates() async {
    if (!mounted) return;
    final coordinates = await userLocationProvider.getUserCoordinate();
    state = state.copyWith(
      lat: coordinates['latitude'].toString(),
      long: coordinates['longitude'].toString(),
    );
  }

  Map<String, dynamic> getUserCoordinates() {
    return {
      'latitude': state.lat,
      'longitude': state.long,
    };
  }

}

final userLocationStateProvider = StateNotifierProvider.autoDispose<UserLocationStateNotifier, UserLocationState>((ref) {
  return UserLocationStateNotifier();
});