import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:ncu_biking/controllers/playing/obstacle.dart';

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
      _sprites.add(game.spriteManager.birds[i]);
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
      game.size.x / 2 + (_rightForward ? -1 : 1) * 520 * game.scale,
      size.y + Random().nextInt((game.size.y / 3 - size.y).toInt()),
    );
    super.onMount();
  }

  @override
  void update(double dt) {
    if (game.isPlaying) {
      position.y += (game.baseSpeed + _speed) * dt * game.scale;
      position.x += (_rightForward ? 1 : -1) * _speed * dt * game.scale;
      if (position.y > game.size.y + size.y ||
          position.x < game.size.x / 2 - 550 * game.scale ||
          position.x > game.size.x / 2 + 550 * game.scale) {
        removeFromParent();
      }
    }
    _animationTimer.update(dt);
    super.update(dt);
  }
}
