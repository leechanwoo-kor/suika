import 'dart:async';

import 'package:flame/components.dart';

class ScoreComponent extends TextComponent {
  ScoreComponent() : super(text: 'Score: 0');

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(10, 15);
  }

  void updateScore(int newScore) {
    text = 'Score: $newScore';
  }
}
