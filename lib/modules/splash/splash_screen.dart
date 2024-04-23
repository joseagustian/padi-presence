import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:padi/modules/splash/presenters/widgets/splash_image.dart';
import 'package:padi/modules/splash/splash_provider.dart';

import 'splash_animation_state_provider.dart';

class PadiSplashScreen extends ConsumerStatefulWidget {
  const PadiSplashScreen({super.key});

  @override
  ConsumerState<PadiSplashScreen> createState() => _PadiSplashScreenState();
}

class _PadiSplashScreenState extends ConsumerState<PadiSplashScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(splashStateProvider);
    ref.watch(splashNotifierProvider.notifier);
    return Scaffold(
      body: Center(
        child: SplashImage(
          imageSize: state.imageSize,
          animated: state.animated,
        ),
      ),
    );
  }
}
