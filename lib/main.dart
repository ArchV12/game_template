// ignore_for_file: unnecessary_overrides

import 'package:desktop_window/desktop_window.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_template/game_router.dart';
import 'constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class GameTemplate extends FlameGame with HasTappables, HasKeyboardHandlerComponents {
  late final RouterComponent router;

  Future setWindowSize() async {
    if (Platform.isWindows || Platform.isMacOS) {
      await DesktopWindow.setWindowSize(Constants.screenSize);
    }
  }

  @override
  Future<void> onLoad() async {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    await Flame.device.setLandscape();
    setWindowSize();
    camera.viewport = FixedResolutionViewport(Constants.screenSizeVec);
    _preloadFont();
    await _precacheImages();

    add(router = GameRouter());
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
  }

  void _preloadFont() {
    // Hack to preload the google font
    TextComponent(
      textRenderer: TextPaint(
        style: GoogleFonts.rockSalt(),
      ),
    );
    TextComponent(
      textRenderer: TextPaint(
        style: GoogleFonts.rubik(),
      ),
    );
  }

  Future<void> _precacheImages() async {
    // await Flame.images.load('bottle.png');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void onRemove() {
    FlameAudio.bgm.stop();
    debugPrint('Game Shutdown!');
    super.onRemove();
  }
}

class ReassembleListener extends StatefulWidget {
  const ReassembleListener({super.key, required this.onReassemble, required this.child});

  final VoidCallback onReassemble;
  final Widget child;

  @override
  ReassembleListenerState createState() => ReassembleListenerState();
}

class ReassembleListenerState extends State<ReassembleListener> {
  @override
  void reassemble() {
    super.reassemble();
    widget.onReassemble();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

void main() {
  final game = GameTemplate();
  runApp(
    ReassembleListener(
      onReassemble: () {
        FlameAudio.bgm.stop();
        debugPrint('Restarting!');
      },
      child: MaterialApp(
        home: Scaffold(
          body: GameWidget(game: game),
        ),
      ),
    ),
  );
}
