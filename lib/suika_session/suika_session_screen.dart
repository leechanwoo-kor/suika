import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'route/navigator_key.dart';
import 'suika_widget.dart';

class SuikaSessionScreen extends StatefulWidget {
  const SuikaSessionScreen({super.key});

  @override
  State<SuikaSessionScreen> createState() => _SuikaSessionScreenState();
}

class _SuikaSessionScreenState extends State<SuikaSessionScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Suika',
      home: Scaffold(
        body: SafeArea(
          child: GameWidget(
            game: SuikaGame(),
          ),
        ),
      ),
    );
  }
}
