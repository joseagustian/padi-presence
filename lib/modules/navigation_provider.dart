
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationProvider = StateNotifierProvider<NavigationState, int>((ref) {
  return NavigationState();
});

class NavigationState extends StateNotifier<int> {
  NavigationState() : super(0);

  void setPosition(int index) {
    state = index;
  }
}