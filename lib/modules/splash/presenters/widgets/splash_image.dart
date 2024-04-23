import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashImage extends ConsumerWidget {
  final double imageSize;
  final bool animated;

  const SplashImage({
    super.key,
    required this.imageSize,
    required this.animated
  });

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: 1.0,
          curve: Curves.fastOutSlowIn,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.bounceInOut,
            width: MediaQuery.of(context).size.width * 0.7 * (animated ? 1.0 : imageSize),
            height: MediaQuery.of(context).size.height * 0.5 * (animated ? 1.0 : imageSize),
            child: const Image(
              image: AssetImage('assets/images/logo-padi.png'),
            ),
          ),
        ),
      ],
    );
  }
}