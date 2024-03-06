import 'package:flame/components.dart';
import 'package:suika/suika_session/suika_widget.dart';

import '../components/ball.dart';

class GenerateBall {
  SuikaGame game;
  GenerateBall(this.game);
  Future<void> generateBall() async {
    final ball = Ball(
      Vector2.zero(),
      false,
      true,
      1,
    );
    Future.delayed(Duration(milliseconds: 100), () {
      game.world.add(ball);
    });
  }
}
