import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class VerticalLineComponent extends PositionComponent {
  late final Paint paint;
  final double screenWidth;
  final double screenHeight;
  bool Function() canFollowMouse;

  VerticalLineComponent(
      {required this.screenWidth,
      required this.screenHeight,
      required this.canFollowMouse}) {
    paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 5;
    size = Vector2(5, screenHeight);
  }

  @override
  void render(Canvas canvas) {
    if (canFollowMouse()) {
      super.render(canvas);
      canvas.drawLine(Offset(0, 0), Offset(0, size.y), paint);
    }
  }

  void updatePosition(double mouseX) {
    position.x = mouseX - size.x / 2;
  }
}
