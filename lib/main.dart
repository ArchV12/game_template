// ignore_for_file: unnecessary_overrides

import 'package:desktop_window/desktop_window.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart' hide Viewport;
import 'package:flutter/material.dart' hide Viewport;
import 'package:flutter/services.dart';
import 'package:game_template/audio_manager.dart';
import 'package:game_template/constants.dart';
import 'package:game_template/game_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class GameTemplate extends FlameGame with DragCallbacks, ScrollDetector, ScaleDetector, HasKeyboardHandlerComponents {
  late final RouterComponent router;
  late CameraComponent? cameraComponent;
  late AudioManager audioManager;
  bool _allowPanning = true;
  bool _allowZoom = true;
  late double startZoom;
  double zoomPerScrollUnit = 0.1;

  // Sets the window size that will appear at startup for desktop platforms
  Future _setWindowSize() async {
    if (Platform.isWindows || Platform.isMacOS) {
      await DesktopWindow.setWindowSize(Constants.screenSize);
    }
  }

  @override
  Future<void> onLoad() async {
    debugPrint("Game is loading...");

    // Set up and initialize various things
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    await Flame.device.setLandscape();
    _setWindowSize();
    _preloadFont();
    await _precacheImages();

    // Add the router.  The first screen that shows up
    // will be the initialRouter parameter in GameRouter.
    add(router = GameRouter());
  }

  // Hack to preload the google fonts, otherwise the first
  // instance of using the font will not be the correct font
  // Precache any fonts you plan to use like the exmaples below.
  void _preloadFont() {
    debugPrint('Preloading fonts...');
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

  // You can optionally precache images that used.  Good idea especially
  // to do with with larger images like backgrounds, etc.
  Future<void> _precacheImages() async {
    debugPrint('Precache images...');
    // await Flame.images.load('background.png');
  }

  // A convenience function that scene classes can use to create a cameraComponet that
  // the game is aware of.  Each scene should define its own world and provide it here
  CameraComponent createCameraForScene({
    required Component scene,
    required World world,
    bool canPan = false,
    bool canZoom = false,
    Viewport? viewport,
    Viewfinder? viewfinder,
  }) {
    _allowPanning = canPan;
    _allowZoom = canZoom;

    if (viewport != null || viewfinder != null) {
      cameraComponent = CameraComponent(
        viewport: viewport,
        viewfinder: viewfinder,
        world: world,
      );
    } else {
      cameraComponent = CameraComponent.withFixedResolution(
        world: world,
        width: Constants.screenSize.width,
        height: Constants.screenSize.height,
      );
    }

    scene.addAll([cameraComponent!, world]);
    return cameraComponent!;
  }

  // Several methods below are used for panning and zooming of a scene if enabled
  // for their camera component.  The reason this is done here at the game level and not
  // at the scene level is that the scaling mixins only work on FlameGame dervied classes :(
  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (cameraComponent == null) return;
    if (!_allowPanning) return;

    cameraComponent!.moveBy((event.delta * -1.0) / cameraComponent!.viewfinder.zoom);
    super.onDragUpdate(event);
  }

  void clampZoom() {
    if (cameraComponent == null) return;
    cameraComponent!.viewfinder.zoom = cameraComponent!.viewfinder.zoom.clamp(0.05, 4.0);
  }

  @override
  void onScroll(PointerScrollInfo info) {
    if (cameraComponent == null) return;
    if (!_allowZoom) return;

    double zoom = cameraComponent!.viewfinder.zoom - info.scrollDelta.game.y.sign * zoomPerScrollUnit;
    if (zoom < 0.4 || zoom > 4.0) return;
    zoom = zoom.clamp(0.4, 4.0);
    cameraComponent!.viewfinder.add(
      ScaleEffect.to(
        Vector2.all(zoom),
        CurvedEffectController(0.1, Curves.linear),
      ),
    );
  }

  @override
  void onScaleStart(ScaleStartInfo info) {
    if (!_allowZoom) return;
    startZoom = cameraComponent!.viewfinder.zoom;
    super.onScaleStart(info);
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    if (!_allowZoom) return;
    final currentScale = info.scale.global;
    if (!currentScale.isIdentity()) {
      cameraComponent!.viewfinder.zoom = startZoom * currentScale.y;
      clampZoom();
    } else {
      final delta = info.delta.game;
      cameraComponent!.viewfinder.position.translate(-delta.x, -delta.y);
    }
  }

  // Common overrides.  Usually not used at the GAME level, any Component
  // can override these methods themselves.
  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onRemove() {
    // Stop background music on shutdown
    // FlameAudio.bgm.stop();
    debugPrint("Game is shutting down...");
    super.onRemove();
  }
}

// This class is used to intercept hot reload events so you can do various restarting actions
// Stopping background music is a good one, otherwise you'll end up playing multiple music tracks!
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
        // Stop background music on hot reload
        // FlameAudio.bgm.stop();
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
