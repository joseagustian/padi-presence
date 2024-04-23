import 'package:flutter/material.dart';

class PulseCircleMarker extends StatefulWidget {
  const PulseCircleMarker({super.key});

  @override
  State<PulseCircleMarker> createState() => _PulseCircleMarkerState();
}

class _PulseCircleMarkerState extends State<PulseCircleMarker> with SingleTickerProviderStateMixin {

  double _radius = 5.5;

  late AnimationController _animationController;


  @override
  void initState() {
    super.initState();
    _startPulseAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startPulseAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );

    final tween = Tween(begin: 5.5, end: 7.5);

    _animationController.repeat(reverse: true);
    _animationController.addListener(() {
      if (mounted) {
        setState(() {
          _radius = tween.evaluate(curvedAnimation);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PulsingCirclePainter(
        MediaQuery.of(context).size.width * 0.5,
        _radius,
      ),
    );
  }
}

class PulsingCirclePainter extends CustomPainter {
  final double radius;
  final double pulsingCircleSize;

  PulsingCirclePainter(this.radius, this.pulsingCircleSize);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint bluePaint = Paint()
      ..color = Colors.blueGrey.shade700
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 10, whitePaint);
    canvas.drawCircle(center, pulsingCircleSize, bluePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
