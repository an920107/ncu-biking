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
    sprite = game.spriteManager.cars[Random().nextInt(3)];
    anchor = Anchor.center;
    angle = pi / 180 * 90;
    return super.onLoad();
  }

  @override
  void onMount() {
    position = Vector2(
      game.size.x / 2 + (Random().nextBool() ? 1 : -1) * 400 * game.scale,
      -size.y / 2,
    );
    super.onMount();
  }

  @override
  void update(double dt) {
    if (game.isPlaying) {
      position.y += game.baseSpeed * dt * game.scale;
      if (position.y > game.size.y + size.y) {
        removeFromParent();
      }
    }
    super.update(dt);
  }
}
