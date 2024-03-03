import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:suika/suika_session/suika_init.dart';

import 'components/ground_component.dart';
import 'constants.dart';
import 'controllers/generate_ball.dart';
import 'suika_onload.dart';

final screenSize = Vector2(720, 1280);
final worldSize = Vector2(7.2, 12.8);

class SuikaGame extends Forge2DGame {
  SuikaGame()
      : super(
          zoom: 10,
          gravity: Vector2(0, 9.8),
          world: SuikaWorld(),
        ) {
    SuikaInit(this).init(screenSize);
  }
}

class SuikaWorld extends Forge2DWorld
    with TapCallbacks, HasGameReference<SuikaGame> {
  @override
  Future<void> onLoad() async {
    super.onLoad();

    await GameOnload(game).onLoad();

    // camera.viewport = FixedResolutionViewport(resolution: screenSize);

    // add(_Background(size: screenSize)
    //     );
    // add(totalBodies);

    // camera.moveTo(worldSize / 2);

    await game.loadSprite('fruit0.png');

    add(GroundComponent());

    @override
    void update(double dt) {
      super.update(dt);
    }

    @override
    Color backgroundColor() {
      return Colors.red;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onTapDown(TapDownEvent event) {
    GenerateBall(game).generateBall();
    print('onTapDown');
  }
}

class _Background extends PositionComponent {
  _Background({super.size});

  @override
  void render(Canvas canvas) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), bluePaint);
  }
}

class SuikaWidget extends StatelessWidget {
  const SuikaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: SuikaGame(),
    );
  }
}
