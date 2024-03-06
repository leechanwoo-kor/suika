import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../style/palette.dart';
import 'infinite_widget.dart';

class InfiniteSessionScreen extends StatefulWidget {
  const InfiniteSessionScreen({super.key});

  @override
  State<InfiniteSessionScreen> createState() => _InfiniteSessionScreenState();
}

class _InfiniteSessionScreenState extends State<InfiniteSessionScreen> {
  final InfiniteGame _game = InfiniteGame();

  void _pauseGame() {
    // 게임 일시 중단 로직
    _game.pauseEngine();
  }

  void _resumeGame() {
    // 게임 재개 로직
    _game.resumeEngine();
  }

  int _steps = 0; // 오른 계단 수
  CharacterDirection _direction = CharacterDirection.right; // 초기 방향

  void _climbStair() {
    setState(() {
      _steps++; // 계단 수 증가
    });
  }

  void _toggleDirection() {
    setState(() {
      _direction = _direction == CharacterDirection.left
          ? CharacterDirection.right
          : CharacterDirection.left; // 방향 전환
    });
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Infinite'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.pause),
            onPressed: _pauseGame,
          ),
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: _resumeGame,
          ),
        ],
      ),
      backgroundColor: palette.backgroundMain,
      body: Center(
        child: InfiniteWidget(),
      ),
    );
  }
}
