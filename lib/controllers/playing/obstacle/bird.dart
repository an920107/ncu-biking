import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:ncu_biking/controllers/playing/obstacle/obstacle.dart';

class Bird extends Obstacle {
  Bird({
    super.coefficient = 0.1,
    super.relativeX = 0.5,
    super.relativeY = 0.6,
  });

  final _sprites = Queue<Sprite>();
  final bool _rightForward = Random().nextBool();
  final double _speed = 300;
  late Timer _animationTimer;

  @override
  FutureOr<void> onLoad() async {
    for (int i = 0; i < 4; i++) {
      _sprites.add(gameRef.spriteManager.birds[i]);
    }
    sprite = _sprites.first;
    anchor = Anchor.center;
    angle = pi / 180 * (_rightForward ? 225 : -45);

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
      gameRef.size.x / 2 + (_rightForward ? -1 : 1) * 520 * gameRef.scale,
      size.y + Random().nextInt((gameRef.size.y / 3 - size.y).toInt()),
    );
    super.onMount();
  }

  @override
  void update(double dt) {
    if (gameRef.isPlaying) {
      position.y += (gameRef.baseSpeed + _speed) * dt * gameRef.scale;
      position.x += (_rightForward ? 1 : -1) * _speed * dt * gameRef.scale;
      if (position.y > gameRef.size.y + size.y ||
          position.x < gameRef.size.x / 2 - 550 * gameRef.scale ||
          position.x > gameRef.size.x / 2 + 550 * gameRef.scale) {
        removeFromParent();
      }
    }
    _animationTimer.update(dt);
    super.update(dt);
  }
}
