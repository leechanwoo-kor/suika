import 'package:flame/components.dart';
import 'package:suika/suika_session/suika_widget.dart';

import '../components/ball.dart';
import '../game_state.dart';

class GenerateBall {
  SuikaGame game;
  GenerateBall(this.game);

  // bool get canGenerateBall => gameRef.components
  //     .where((e) => e is Ball && e.moving && !e.landed)
  //     .isEmpty;

  ///生成新球
  Future<void> generateBall() async {
    // if (gameRef.hide) return;
    // if (!canGenerateBall) return;

    // if (GameState.gameStatus != GameStatus.start) return;
    // if (GameState.lastBall != null) {
    //   GameState.lastBall.fallPosition.x = x;
    //   GameState.lastBall.moving = true;
    // }
    // final level = await Levels.generateLevel();
    // final position = Vector2(x, gameRef.viewport.vw(Levels.radius(level) + 5));
    print('generateBall');
    final ball = new Ball(
      Vector2.zero(),
      false,
      true,
      1,
    );
    // Ball.create(
    //   gameRef,
    //   position: Vector2(worldSize.x / 2, 0),
    //   moving: false,
    //   bounce: true,
    //   level: 1,
    // );
    Future.delayed(Duration(milliseconds: 600), () {
      print('add ball');
      game.world.add(ball);
    });
    // GameState.lastBall = ball;
  }
}
