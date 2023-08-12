import 'package:flame/game.dart';
import 'package:game_template/flutter_dialog.dart';
import 'package:game_template/main.dart';
import 'package:game_template/scenes/game_scene.dart';
import 'package:game_template/scenes/splash_scene.dart';

class GameRouter extends RouterComponent {
  GameRouter()
      : super(
          routes: {
            'splash': Route(SplashScene.new),
            'gameScene': Route(GameScene.new),
            //'mainmenu': Route(MainMenuScene.new),
            'flutterDialog': OverlayRoute(
              (context, game) {
                return FlutterDialog(gameRef: game as GameTemplate);
              },
            )
          },
          initialRoute: 'splash',
        );
}
