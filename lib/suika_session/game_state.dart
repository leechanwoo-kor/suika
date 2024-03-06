import 'dart:async';

import 'package:flame/components.dart';

typedef ComponentFunction = FutureOr<void> Function(Component);

class GameSate {
  static GameStatus gameStatus = GameStatus.start;

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
