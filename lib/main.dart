import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: SuikaGame()));
}

class SuikaGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    // 게임 초기 설정, 필요한 리소스 로드 등
  }

  @override
  void update(double dt) {
    super.update(dt);
    // 게임 로직 업데이트
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // 게임 렌더링 로직
  }
}

class Fruit extends SpriteComponent {
  FruitType type;

  Fruit({required this.type, Sprite? sprite, Vector2? position, Vector2? size})
      : super(sprite: sprite, position: position, size: size);

  void combine(Fruit other) {
    // 같은 종류의 과일을 결합하여 크기를 증가시키는 로직
  }
}

enum FruitType { Melon, Pineapple, Watermelon }
