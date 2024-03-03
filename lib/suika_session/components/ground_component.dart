import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:suika/suika_session/suika_widget.dart';

class GroundComponent extends BodyComponent {
  var debugMode = true;

  @override
  Body createBody() {
    final bodyDef = BodyDef(
      position: Vector2(0, worldSize.y),
      type: BodyType.static,
    );

    final shape = EdgeShape()..set(Vector2(-worldSize.x, -1), Vector2(worldSize.x, 0));
    final fixtureDef = FixtureDef(shape)..friction = 0.7;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
