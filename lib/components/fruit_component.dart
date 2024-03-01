import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:suika/components/ground_component.dart';

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
      isFalling = false;
      // Stop the fruit from falling or implement bounce logic
      // velocity = Vector2.zero(); // Stops the fruit
      velocity.y = -velocity.y * 0.5;
      // For a simple bounce effect, you could reverse the y velocity, for example
      // velocity = Vector2(velocity.x, -velocity.y * bounceFactor);
    }
  }
}