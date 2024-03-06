import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InfiniteGame extends Forge2DGame {
  InfiniteGame() : super(gravity: Vector2(0, -10));
}

class InfiniteWorld extends Forge2DWorld with HasGameRef<InfiniteGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(Stair()); // 계단 추가
    add(Character()); // 캐릭터 추가
  }
}

class InfiniteWidget extends StatelessWidget {
  const InfiniteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: InfiniteGame(),
    );
  }
}

enum CharacterDirection { left, right }

class Stair extends BodyComponent {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    final shape = PolygonShape()..setAsBoxXY(2.0, 0.2); // 계단의 크기
    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.0 // 반발력 설정
      ..friction = 0.5; // 마찰력 설정
    final bodyDef = BodyDef()
      ..position = Vector2(0, -10) // 초기 위치 설정
      ..type = BodyType.static; // 정적 객체로 설정
    body = world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class Character extends BodyComponent {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    final shape = CircleShape()..radius = 1.0; // 캐릭터의 크기 (반지름)
    final fixtureDef = FixtureDef(shape)
      ..restitution = 0.1 // 캐릭터의 반발력
      ..density = 1.0; // 밀도 설정
    final bodyDef = BodyDef()
      ..position = Vector2(0, 0) // 초기 위치 설정
      ..type = BodyType.dynamic; // 동적 객체로 설정, 움직일 수 있음
    body = world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class GameHUD extends PositionComponent with HasGameRef<InfiniteGame> {
  @override
  Future<void> onLoad() async {
    super.onLoad();

    // 계단 수를 표시하는 TextComponent
    final stairsCount = TextComponent(
      text: 'Stairs: 0',
      position: Vector2(10, 10),
      textRenderer:
          TextPaint(style: TextStyle(fontSize: 24.0, color: Colors.white)),
    );

    // 코인 수를 표시하는 TextComponent
    final coinsCount = TextComponent(
      text: 'Coins: 0',
      position: Vector2(10, 40),
      textRenderer:
          TextPaint(style: TextStyle(fontSize: 24.0, color: Colors.white)),
    );

    add(stairsCount);
    add(coinsCount);
  }

  void updateStairsCount(int count) {
    // 계단 수 업데이트 로직
  }

  void updateCoinsCount(int count) {
    // 코인 수 업데이트 로직
  }
}

class GameControls extends StatelessWidget {
  final InfiniteGame game;

  GameControls(this.game);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            // '오르기' 버튼 로직
            // 예: game.character.jump();
          },
          child: Icon(Icons.arrow_upward),
        ),
        FloatingActionButton(
          onPressed: () {
            // '방향 전환' 버튼 로직
            // 예: game.character.toggleDirection();
          },
          child: Icon(Icons.swap_horiz),
        ),
      ],
    );
  }
}
