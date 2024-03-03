import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:suika/style/palette.dart';
import 'package:suika/suika_session/suika_widget.dart';

import '../game_internals/level_state.dart';

class SuikaSessionScreen extends StatefulWidget {
  const SuikaSessionScreen({super.key});

  @override
  State<SuikaSessionScreen> createState() => _SuikaSessionScreenState();
}

class _SuikaSessionScreenState extends State<SuikaSessionScreen> {
  static final _log = Logger('SuikaSessionScreen');

  bool _ignoreFlag = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return MultiProvider(
      providers: [
        Provider.value(value: 1),
        ChangeNotifierProvider(
          create: (context) => LevelState(
            goal: 1,
            onWin: _playerWon,
          ),
        ),
      ],
      child: IgnorePointer(
        ignoring: _ignoreFlag,
        child: Scaffold(
          backgroundColor: palette.backgroundMain,
          body: Center(
            child: SuikaWidget()
          ),
        ),
      ),
    );
  }

  Future<void> _playerWon() async {
    _log.info('Level ${1} won');
  }
}
