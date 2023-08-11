import 'package:flame/game.dart';

class GameRouter extends RouterComponent {
  GameRouter()
      : super(
          routes: {
            //'splash': Route(SplashScreen.new),
            //'gamescreen': Route(GameScreen.new),
            //'mainmenu': Route(MainMenuScreen.new),
            // 'createNameOverlay': OverlayRoute(
            //   (context, game) {
            //     return CreateNameOverlay(gameRef: game as PotJCGame);
            //   },
            // )
          },
          initialRoute: 'testWalls',
        );
}
