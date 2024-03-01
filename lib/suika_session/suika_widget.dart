import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import '../components/fruit_component.dart';
import '../components/ground_component.dart';
import '../components/vertical_line_component.dart';

// Main game class
class SuikaGame extends FlameGame
    with HasCollisionDetection, MouseMovementDetector, TapDetector {
  final Random _random = Random();
  late FruitComponent fruit;
  late FruitComponent currentFruit;

  late VerticalLineComponent verticalLine;
  Vector2? lastMousePosition;

  bool canFollowMouse = true;
  bool canTap = true;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final ground = GroundComponent();
    await add(ground);

    verticalLine = VerticalLineComponent(
        screenWidth: size.x,
        screenHeight: size.y,
        canFollowMouse: () => canFollowMouse);
    add(verticalLine);

    spawnFruit(Vector2(size.x / 2, 20));
  }

  @override
  void onMouseMove(PointerHoverInfo event) {
    super.onMouseMove(event);
    if (canFollowMouse) {
      lastMousePosition = event.eventPosition.widget;
      if (!fruit.isFalling) {
        // Update position only if the fruit isn't falling
        fruit.position.x = lastMousePosition!.x;
      }

      verticalLine.updatePosition(lastMousePosition!.x);

      Vector2 newPosition =
          Vector2(event.eventPosition.widget.x, fruit.position.y);

      if (newPosition.x < 0) {
        newPosition.x = 0;
      }

      if (newPosition.x > size.x) {
        newPosition.x = size.x;
      }

      fruit.position = newPosition;
    }
  }

  void spawnFruit(Vector2 position) {
    final fruitType = _random.nextInt(3);
    fruit = FruitComponent(fruitType)
      ..position = position
      ..size = Vector2(50, 50);
    add(fruit);
    canTap = false;
    Future.delayed(Duration(milliseconds: 100), () {
      canTap = true;
    });
  }

  @override
  void onTapUp(TapUpInfo info) {
    if (canTap) {
      super.onTapUp(info);
      canFollowMouse = false;

      fruit.startFalling();

      if (lastMousePosition != null) {
        Future.delayed(Duration(milliseconds: 750), () {
          spawnFruit(Vector2(lastMousePosition!.x, 20));
          canFollowMouse = true;
        });
      }
    }
  }
}

// SuikaWidget to integrate the game into a Flutter app
class SuikaWidget extends StatelessWidget {
  const SuikaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: SuikaGame(),
    );
  }
}
