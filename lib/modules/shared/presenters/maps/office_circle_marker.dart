import 'package:flutter/material.dart';

class OfficeCircleMarker extends StatefulWidget {
  const OfficeCircleMarker({super.key});

  @override
  State<OfficeCircleMarker> createState() => _OfficeCircleMarkerState();
}

class _OfficeCircleMarkerState extends State<OfficeCircleMarker> with SingleTickerProviderStateMixin {

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
      painter: PulsingOfficeCirclePainter(
        MediaQuery.of(context).size.width * 0.5,
        _radius,
        Icons.corporate_fare,
      ),
    );
  }
}

class PulsingOfficeCirclePainter extends CustomPainter {
  final double radius;
  final double pulsingCircleSize;
  final IconData locationIcon; // Add an icon data property

  PulsingOfficeCirclePainter(this.radius, this.pulsingCircleSize, this.locationIcon);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint whitePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 10, whitePaint);

    // Draw the location icon inside the circle
    final iconPaint = Paint()..color = Colors.white; // Customize the icon color
    const iconSize = 10.0; // Set the icon size as desired

    // You can use different methods to draw the icon, for example, draw an IconData
    final textPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(locationIcon.codePoint),
        style: TextStyle(
          fontFamily: locationIcon.fontFamily,
          fontSize: iconSize,
          color: iconPaint.color,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);

    final iconX = center.dx - textPainter.width / 2;
    final iconY = center.dy - textPainter.height / 2;
    textPainter.paint(canvas, Offset(iconX, iconY));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


