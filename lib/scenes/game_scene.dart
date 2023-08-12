// ignore_for_file: unnecessary_overrides

import 'dart:async';

import 'package:flame/components.dart';
import 'package:game_template/components/components_barrel.dart';
import 'package:game_template/main.dart';

class GameScene extends Component with HasGameRef<GameTemplate> {
  final world = World();
  late CameraComponent cameraComponent;
  late GameSpriteComponent enterpriseComponent;

  @override
  FutureOr<void> onLoad() async {
    // Create a camera for this scene
    cameraComponent = gameRef.createCameraForScene(
      scene: this,
      world: world,
      canPan: false,
      canZoom: false,
    );

    Sprite starBackground = await Sprite.load('starBackground.jpg');
    world.add(
      SpriteComponent(
        position: Vector2.zero(),
        anchor: Anchor.center,
        sprite: starBackground,
      ),
    );

    Sprite enterpriseSprite = await Sprite.load('enterprise.png');
    enterpriseComponent = GameSpriteComponent(
      position: Vector2.zero(),
      anchor: Anchor.center,
      sprite: enterpriseSprite,
      scale: Vector2.all(0.5),
      canTap: true,
      tapCallback: (component) {
        component.singlePulse(scaleBy: 0.1, pulseTime: 0.1);
      },
    );

    world.add(enterpriseComponent);

    cameraComponent.viewport.add(
      GameTextComponent(
        position: cameraComponent.viewport.size,
        anchor: Anchor.bottomRight,
        text: 'Where is the Flutter?',
        tapCallback: (component) {
          gameRef.router.pushNamed('flutterDialog');
        },
      ),
    );

    return super.onLoad();
  }
}
