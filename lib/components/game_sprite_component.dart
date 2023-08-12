import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';

// An extension of the basic SpriteComponent.  Implements tapping
//
class GameSpriteComponent extends SpriteComponent with TapCallbacks {
  GameSpriteComponent({
    super.anchor,
    super.angle,
    super.children,
    super.nativeAngle,
    super.paint,
    super.position,
    super.priority,
    super.scale,
    super.size,
    super.sprite,
    Function(GameSpriteComponent comp)? effectsDoneCallback,
    this.tapCallback,
    this.canTap = false,
  });

  Function(GameSpriteComponent comp)? effectsDoneCallback;
  Function(GameSpriteComponent comp)? tapCallback;
  bool canTap = false;
  Anchor? savedAnchor;
  Vector2? savedPos;
  bool isMoving = false;

  @override
  void onTapDown(TapDownEvent event) {
    if (canTap) {
      tapCallback?.call(this);
    }
    super.onTapDown(event);
  }

  void moveTo(Vector2 position, double duration) {
    isMoving = true;
    add(
      MoveEffect.to(
        position,
        EffectController(duration: duration),
        onComplete: () {
          isMoving = false;
          effectsDoneCallback?.call(this);
        },
      ),
    );
  }

  void singlePulse({Function? complete, double scaleBy = 0.2, double pulseTime = 0.35}) {
    savedAnchor = anchor;
    savedPos = position;
    anchor = Anchor.center;
    Vector2 destScale = Vector2(scale.x + scaleBy, scale.y + scaleBy);
    add(
      ScaleEffect.to(
        destScale,
        SequenceEffectController([
          LinearEffectController(pulseTime),
          ReverseLinearEffectController(pulseTime),
        ]),
        onComplete: () {
          position = savedPos!;
          anchor = savedAnchor!;
          effectsDoneCallback?.call(this);
        },
      ),
    );
  }
}
