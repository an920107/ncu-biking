import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:ncu_biking/controllers/playing/obstacle.dart';

class Bus extends Obstacle {
  Bus({
    super.coefficient = 0.4,
    super.relativeX = 0.9,
    super.relativeY = 0.6,
  });

  final _sprites = Queue<Sprite>();
  late Timer _animationTimer;

  @override
  FutureOr<void> onLoad() async {
    for (int i = 0; i < 6; i++) {
      _sprites.add(game.spriteManager.buses[i]);
    }
    sprite = _sprites.first;
    anchor = Anchor.center;
    angle = pi / 180 * 90;

    _animationTimer = Timer(
      0.3,
      onTick: () {
        if (_sprites.isNotEmpty) {
          _sprites.add(_sprites.removeFirst());
          sprite = _sprites.first;
        }
      },
      repeat: true,
    );
    return super.onLoad();
  }

  @override
  void onMount() {
    position = Vector2(
      game.size.x / 2,
      game.size.y + size.y / 2,
    );
    super.onMount();
  }

  @override
  void update(double dt) {
    if (game.isPlaying) {
      position.y -= game.baseSpeed * dt * game.scale;
      if (position.y < -size.y) {
        removeFromParent();
      }
    }
    _animationTimer.update(dt);
    super.update(dt);
  }
}
