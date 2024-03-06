import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class FruitComponent extends BodyComponent with ContactCallbacks {
  final int fruitType;
  final double radius;
  late final Color color;
  Vector? initialPosition;

  FruitComponent({required this.fruitType, this.radius = 25}) {
    color = Color(0xFFFFFFFF);
  }

  FruitState state = FruitState.idle;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    debugMode = true;
    final sprite = await Sprite.load('fruit$fruitType.png');
    add(
      SpriteComponent(
        sprite: sprite,
        size: Vector2(5, 5),
        anchor: Anchor.center,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  Body createBody() {
    final shape = CircleShape()
      ..radius = 25
      ..position.setFrom(Vector2(0, 0));
    final fixtureDef = FixtureDef(shape)
      ..userData = this // To be able to determine object in collision
      ..restitution = 0.5
      ..density = 0.5
      ..friction = 0.5;
    final bodyDef = BodyDef()
      ..position = position
      ..type = BodyType.dynamic;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void renderCircle(Canvas canvas, Offset offset, double radius) {
    super.renderCircle(canvas, offset, radius);
  }

  // @override
  // void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
  //   super.onCollision(intersectionPoints, other);

  //   if (other is GroundComponent) {
  //     state = FruitState.idle;
  //     position.y = other.position.y - size.y / 2;
  //   }
  //   if (other is FruitComponent) {
  //     velocity = -velocity*0.5;
  //   }
  // }
}

enum FruitState {
  idle,
  falling,
}
