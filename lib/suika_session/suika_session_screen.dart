import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:suika/style/my_button.dart';
import 'package:suika/style/palette.dart';

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
          body: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkResponse(
                      onTap: () => GoRouter.of(context).push('/settings'),
                      child: Image.asset(
                        'assets/images/settings.png',
                        semanticLabel: 'Settings',
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Expanded(child: ,),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyButton(
                      onPressed: () => GoRouter.of(context).go('/'),
                      child: const Text('Back'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _playerWon() async {
    _log.info('Level ${1} won');
  }
}
