// ignore_for_file: unnecessary_overrides

import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:game_template/components/game_text_component.dart';
import 'package:game_template/main.dart';
import 'package:flutter/material.dart';

// Splash screen scene.  This is the initalRoute specified in the game_router
class SplashScene extends Component with HasGameRef<GameTemplate> {
  final world = World();
  late CameraComponent cameraComponent;

  @override
  FutureOr<void> onLoad() {
    // Create a camera for this scene
    cameraComponent = gameRef.createCameraForScene(scene: this, world: world);

    GameTextComponent splashTitle = GameTextComponent(
      text: 'Splash Screen!',
      position: cameraComponent.viewport.size * 0.5,
      anchor: Anchor.center,
      color: Colors.blueAccent,
      fontSize: 62,
    );

    cameraComponent.viewport.add(splashTitle);

    // Make a fancy effect for the text
    final effect = SequenceEffect([
      ScaleEffect.by(
        Vector2.all(1.2),
        EffectController(
          duration: 0.5,
          curve: Curves.bounceOut,
        ),
      ),
      ScaleEffect.by(
        Vector2.all(0.01),
        EffectController(
          startDelay: 1.0,
          duration: 0.2,
        ),
        onComplete: () {
          gameRef.router.pushReplacementNamed('gameScene');
        },
      ),
      RemoveEffect(),
    ]);

    splashTitle.add(effect);

    return super.onLoad();
  }
}
