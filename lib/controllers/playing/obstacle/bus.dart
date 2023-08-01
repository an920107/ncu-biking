import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:ncu_biking/controllers/playing/obstacle/obstacle.dart';

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
      _sprites.add(await Sprite.load("bus/bus$i.png"));
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
      gameRef.size.x / 2,
      gameRef.size.y + size.y / 2,
    );
    super.onMount();
  }

  @override
  void update(double dt) {
    if (gameRef.isPlaying) {
      position.y -= gameRef.baseSpeed * dt * gameRef.scale;
      if (position.y < -size.y) {
        removeFromParent();
      }
    }
    _animationTimer.update(dt);
    super.update(dt);
  }
}
