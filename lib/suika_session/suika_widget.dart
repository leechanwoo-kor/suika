import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:suika/suika_session/suika_init.dart';

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

    await game.loadSprite('fruit0.png');

    @override
    Color backgroundColor() {
      return Colors.red;
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    GenerateBall(game).generateBall();
  }
}

class SuikaWidget extends StatelessWidget {
  const SuikaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: SuikaGame(),
    );
  }
}
