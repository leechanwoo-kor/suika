import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:suika/components/ground_component.dart';

class FruitComponent extends SpriteComponent with CollisionCallbacks {
  final int fruitType;
  FruitComponent(this.fruitType);

  FruitState state = FruitState.idle;

  Vector2 velocity = Vector2(0, 0); // Initial velocity

  @override
  Future<void> onLoad() async {
    super.onLoad();
    debugMode = true;
    // Load different sprites based on fruit type
    sprite = await Sprite.load('fruit$fruitType.png');
    anchor = Anchor.center;
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    if (state == FruitState.falling) {
      velocity.y += 9.8;
      position.add(velocity * dt);
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is GroundComponent) {
      state = FruitState.idle;
      position.y = other.position.y - size.y / 2;
    }
    if (other is FruitComponent) {
      velocity = -velocity*0.5;
    }
  }
}

enum FruitState {
  idle,
  falling,
}
