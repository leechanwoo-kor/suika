import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Ball extends BodyComponent {
  var debugMode = true;
  Vector2 position = Vector2.zero();
  bool moving = false;
  bool landed = false;
  bool bounce = false;
  int level = 0;

  set sprite(Future<Sprite> sprite) {}

  Ball(this.position, this.moving, this.bounce, this.level) : super();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final sprite = Sprite(game.images.fromCache('fruit0.png'));
    add(SpriteComponent(
        sprite: sprite, size: Vector2(5, 5), anchor: Anchor.center));
  }

  @override
  Body createBody() {
    print('create body');

    var position = Vector2.zero();
    print(position);
    var worldPosition = 0;

    final bodyDef = BodyDef(
      position: position,
      type: BodyType.dynamic,
    );

    final shape = CircleShape()..radius = 5;
    final fixtureDef = FixtureDef(shape);

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
