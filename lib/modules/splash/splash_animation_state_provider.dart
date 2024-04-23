import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreenAnimationState {
  final double imageSize;
  final bool animated;
  final bool showImage;

  SplashScreenAnimationState({
    required this.imageSize,
    required this.animated,
    required this.showImage,
  });

  SplashScreenAnimationState copyWith({
    double? imageSize,
    bool? animated,
    bool? showImage,
  }) {
    return SplashScreenAnimationState(
      imageSize: imageSize ?? this.imageSize,
      animated: animated ?? this.animated,
      showImage: showImage ?? this.showImage,
    );
  }

}

class SplashImageNotifier extends StateNotifier<SplashScreenAnimationState> {
  SplashImageNotifier() : super(SplashScreenAnimationState(
    imageSize: 0,
    animated: false,
    showImage: true,
  )) {
    Future.delayed(Duration.zero, () {
      setAnimated();
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      setShowImage();
    });
  }

  void setAnimated() {
    state = state.copyWith(
      imageSize: 1.0,
      animated: true,
      showImage: true,
    );
  }

  void setShowImage() {
    state = state.copyWith(
      imageSize: 0,
      animated: true,
      showImage: false,
    );
  }

}

final splashStateProvider = StateNotifierProvider<SplashImageNotifier, SplashScreenAnimationState>((ref) {
  return SplashImageNotifier();
});