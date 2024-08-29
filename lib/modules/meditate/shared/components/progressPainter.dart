import 'dart:math';

import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProgressPainter extends CustomPainter {
  final double progress;

  ProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint trackPaint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    Paint progressPaint = Paint()
      ..color = AppColors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    Paint startCirclePaint = Paint()
      ..color = AppColors.white
      ..style = PaintingStyle.fill;

    Paint innerCirclePaint = Paint()
      ..color = AppColors.yellow
      ..style = PaintingStyle.fill;

    double radius = (size.width / 2) - 4;
    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, trackPaint);

    double sweepAngle = 2 * pi * progress;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        sweepAngle, false, progressPaint);

    Offset circleCenter = Offset(
      center.dx + radius * cos(sweepAngle - pi / 2),
      center.dy + radius * sin(sweepAngle - pi / 2),
    );

    Offset startCircleCenter = Offset(
      center.dx + radius * cos(sweepAngle - pi / 2),
      center.dy + radius * sin(sweepAngle - pi / 2),
    );

    canvas.drawCircle(circleCenter, 10, startCirclePaint);
    canvas.drawCircle(startCircleCenter, 5, innerCirclePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
