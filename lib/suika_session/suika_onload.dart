import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

import 'components/wall.dart';
import 'controllers/generate_ball.dart';
import 'suika_widget.dart';

class GameOnload {
  SuikaGame game;
  GameOnload(this.game);

  static bool inited = false;

  static Future<void> init() async {}

  Future<void> onLoad() async {
    game.camera.viewport = FixedResolutionViewport(
      resolution: screenSize,
    );
    game.camera.viewport.add(FpsTextComponent());

    await GenerateBall(game).generateBall();
    game.world.addAll(createBoundaries());
  }

  List<Component> createBoundaries() {
    final visibleRect = game.camera.visibleWorldRect;
    final topLeft = visibleRect.topLeft.toVector2();
    final topRight = visibleRect.topRight.toVector2();
    final bottomRight = visibleRect.bottomRight.toVector2();
    final bottomLeft = visibleRect.bottomLeft.toVector2();

    return [
      Wall(topLeft, topRight),
      Wall(topRight, bottomRight),
      Wall(bottomLeft, bottomRight),
      Wall(topLeft, bottomLeft),
    ];
  }
}
