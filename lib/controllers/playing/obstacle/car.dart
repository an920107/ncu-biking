import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:ncu_biking/controllers/playing/obstacle.dart';

class Car extends Obstacle {
  Car({
    super.coefficient = 0.3,
    super.relativeY = 0.6,
  });

  @override
  FutureOr<void> onLoad() async {
    sprite = gameRef.spriteManager.cars[Random().nextInt(3)];
    anchor = Anchor.center;
    angle = pi / 180 * 90;
    return super.onLoad();
  }

  @override
  void onMount() {
    position = Vector2(
      gameRef.size.x / 2 + (Random().nextBool() ? 1 : -1) * 400 * gameRef.scale,
      -size.y / 2,
    );
    super.onMount();
  }

  @override
  void update(double dt) {
    if (gameRef.isPlaying) {
      position.y += gameRef.baseSpeed * dt * gameRef.scale;
      if (position.y > gameRef.size.y + size.y) {
        removeFromParent();
      }
    }
    super.update(dt);
  }
}
