import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';

void main() {
  runApp(GameWidget(game: SuikaGame()));
}

final screenSize = Vector2(1500, 1700);

class SuikaGame extends Forge2DGame {
  SuikaGame()
      : super(
          zoom: 100,
          gravity: Vector2(0, 30),
          cameraComponent: CameraComponent.withFixedResolution(
            width: screenSize.x,
            height: screenSize.y,
          ),
        );
  final Random _random = Random();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    camera.backdrop.add(_Background(size: screenSize));

    await images.loadAll(['WATERMELON.png', 'MELON.png', 'APPLE.png']);
    FlameAudio.audioCache.loadAll(['pop.mp3', 'pop2.mp3']);
    createFruit(Vector2(1000, 100));
  }

  void createFruit(Vector2 position) {
    final fruitType =
        FruitType.values[_random.nextInt(FruitType.values.length)];
    final fruit = Fruit(
      type: fruitType,
      sprite: Sprite(images.fromCache('${fruitType.name}.png')),
      position: position.clone(),
      size: Vector2(50, 50),
      gameRef: this,
    );
    add(fruit);
    FlameAudio.play('pop.mp3');
  }
}

class _Background extends PositionComponent {
  _Background({super.size});
  @override
  void render(Canvas canvas) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y),
        Paint()..color = Colors.transparent);
  }
}

class EmotionBall extends BodyComponent {
  final String assetURL;

  EmotionBall({required this.assetURL});
  double size = 1.6.w;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final sprite = Sprite(game.images.fromCache(assetURL));
    add(
      SpriteComponent(
        sprite: sprite,
        size: Vector2(3.2.w, 3.2.w),
        anchor: Anchor.center,
      ),
    );
  }
}

class Fruit extends SpriteComponent with DragCallbacks {
  final SuikaGame gameRef;
  FruitType type;
  bool _isDragged = false;
  Vector2? initialPosition;

  Fruit({
    required this.type,
    required Sprite? sprite,
    required Vector2? position,
    required Vector2? size,
    required this.gameRef,
  }) : super(sprite: sprite, position: position, size: size) {
    initialPosition = position?.clone();
  }

  @override
  void onDragStart(DragStartEvent event) {
    _isDragged = true;
    FlameAudio.play('pop2.mp3');
  }

  @override
  void onDragEnd(DragEndEvent event) {
    _isDragged = false;
    fall().then((_) => gameRef.createFruit(initialPosition!));
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (_isDragged) {
      // position += event.delta;
      position.add(Vector2(event.delta.x, 0));
    }
  }

  Future<void> fall() async {
    final fallEffect = MoveEffect.to(
      Vector2(position.x, gameRef.size.y - size.y),
      EffectController(duration: 0.5, curve: Curves.easeOut),
    );
    await add(fallEffect);
  }
}

enum FruitType { MELON, APPLE, WATERMELON }
