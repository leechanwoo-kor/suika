import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

// Main game class
class SuikaGame extends FlameGame with MouseMovementDetector, TapDetector {
  final Random _random = Random();
  late FruitComponent fruit;
  Vector2? lastMousePosition;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final ground = GroundComponent();
    await add(ground);

    spawnNewFruit(Vector2(size.x / 2, 20));
  }

  @override
  void onMouseMove(PointerHoverInfo event) {
    super.onMouseMove(event);
    lastMousePosition = event.eventPosition.widget;
    if (!fruit.isFalling) { // Update position only if the fruit isn't falling
      fruit.position.x = lastMousePosition!.x - fruit.size.x / 2;
    }
    Vector2 newPosition = Vector2(event.eventPosition.widget.x - fruit.size.x / 2, fruit.position.y);


    if (newPosition.x < 0) {
      newPosition.x = 0;
    }

    if (newPosition.x > size.x - fruit.size.x) {
      newPosition.x = size.x - fruit.size.x;
    }

    fruit.position = newPosition;
  }

  void spawnFruit({bool spawnFirstFruit = false}) {
    final fruitType = _random.nextInt(3);
    final Vector2 initialPosition;
    if (spawnFirstFruit) {
      // Position the first fruit in the center of the screen
      initialPosition = Vector2(size.x / 2, 100);
    } else {
      // Random position for subsequent fruits
      initialPosition = Vector2(_random.nextDouble() * size.x, 0);
    }

    final fruitComponent = FruitComponent(fruitType)
      ..position = initialPosition
      ..size = Vector2.all(50.0);
    add(fruitComponent);
  }

  void spawnNewFruit(Vector2 position) {
    final fruitType = _random.nextInt(3);
    fruit = FruitComponent(fruitType)
      ..position = position
      ..size = Vector2(50, 50);
    add(fruit);
  }

  @override
  void onTapUp(TapUpInfo info) {
    super.onTapUp(info);
    fruit.startFalling();
    if (lastMousePosition != null) {
      spawnNewFruit(Vector2(lastMousePosition!.x - fruit.size.x / 2, 20));
    }
  }
}

class FruitComponent extends SpriteComponent with CollisionCallbacks {
  bool isFalling = false;

  void startFalling() {
    isFalling = true;
  }

  Vector2 velocity = Vector2(0, 0); // Initial velocity
  final int fruitType;

  FruitComponent(this.fruitType);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Load different sprites based on fruit type
    sprite = await Sprite.load('fruit$fruitType.png');
    anchor = Anchor.center;
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isFalling) {
      velocity.y += 9.8;
      position.add(velocity * dt);
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is GroundComponent) {
      // Stop the fruit from falling or implement bounce logic
      // velocity = Vector2.zero(); // Stops the fruit
      velocity.y = -velocity.y * 0.5;
      // For a simple bounce effect, you could reverse the y velocity, for example
      // velocity = Vector2(velocity.x, -velocity.y * bounceFactor);
    }
  }
}

class GroundComponent extends PositionComponent
    with CollisionCallbacks, HasGameRef<SuikaGame> {
  late Paint paint;
  @override
  Future<void> onLoad() async {
    super.onLoad();
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
