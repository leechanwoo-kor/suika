import 'package:flame/camera.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

List<Wall> createBoundaries(Viewport viewport) {
  final screenSize = Vector2(viewport.size.x, viewport.size.y);
  final topRight = (screenSize / 2);
  final bottomLeft = topRight * -1;
  final topLeft = Vector2(bottomLeft.x, topRight.y);
  final bottomRight = topLeft * -1;

  return [
    Wall(topLeft, topRight, 1),
    Wall(topRight, bottomRight, 2),
    Wall(bottomRight, bottomLeft, 3),
    Wall(bottomLeft, topLeft, 4),
  ];
}

class Wall extends BodyComponent {
  final Vector2 start;
  final Vector2 end;
  final int side;

  Wall(this.start, this.end, this.side);

  @override
  Body createBody() {
    final shape = PolygonShape();
    shape.setAsEdge(start, end);

    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.0
      ..friction = 0.1;

    final bodyDef = BodyDef()
      ..userData = this
      ..position = Vector2.zero()
      ..type = BodyType.static;

    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
