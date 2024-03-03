import 'dart:async';

import 'package:flame/components.dart';

import 'components/ball.dart';

typedef ComponentFunction = FutureOr<void> Function(Component);

class GameSate {
  static GameStatus gameStatus = GameStatus.start;
  // static Ball lastBall;

  // static Future<void> init() async {
  //   lastBall = Ball();
  // }

  GameSate({
    required this.add,
    required this.camera,
  });
  final ComponentFunction add;
  final CameraComponent camera;

  Vector2? draggingPosition;
  bool isDragging = false;
}

enum GameStatus {
  start,
  pause,
  over,
  win,
  end,
}
