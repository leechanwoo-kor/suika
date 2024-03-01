import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:suika/suika_session/suika_widget.dart';

class GroundComponent extends PositionComponent
    with CollisionCallbacks, HasGameRef<SuikaGame> {
  late Paint paint;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    debugMode = true;
    // Assuming the ground is at the bottom of the screen and spans the entire width
    size = Vector2(gameRef.size.x, 20);
    position = Vector2(0, gameRef.size.y - 20);
    anchor = Anchor.topLeft;

    add(RectangleHitbox());

    paint = Paint()..color = Colors.green;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Draw the ground rectangle
    canvas.drawRect(size.toRect(), paint);
  }
}
