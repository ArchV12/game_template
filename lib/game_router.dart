import 'package:flame/game.dart';
import 'package:game_template/scenes/game_scene.dart';
import 'package:game_template/scenes/splash_scene.dart';

class GameRouter extends RouterComponent {
  GameRouter()
      : super(
          routes: {
            'splash': Route(SplashScene.new),
            'gameScene': Route(GameScene.new),
            //'mainmenu': Route(MainMenuScene.new),
            // 'createNameOverlay': OverlayRoute(
            //   (context, game) {
            //     return CreateNameOverlay(gameRef: game as PotJCGame);
            //   },
            // )
          },
          initialRoute: 'splash',
        );
}
