import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:ncu_biking/controllers/playing/obstacle.dart';

class Person extends Obstacle {
  Person({
    super.coefficient = 0.08,
    super.relativeX = 0.4,
  });

  final _sprites = Queue<Sprite>();
  final bool _rightForward = Random().nextBool();
  final double _speed = 500;
  late Timer _animationTimer;

  @override
  FutureOr<void> onLoad() async {
    for (int i = 0; i < 4; i++) {
      _sprites.add(gameRef.spriteManager.persons[i]);
    }
    sprite = _sprites.first;
    anchor = Anchor.center;
    if (_rightForward) flipHorizontally();

    _animationTimer = Timer(
      0.25,
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
      size.y + Random().nextInt((gameRef.size.y / 2 - size.y).toInt()),
    );
    super.onMount();
  }

  @override
  void update(double dt) {
    if (gameRef.isPlaying) {
      position.y += gameRef.baseSpeed * dt * gameRef.scale;
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
