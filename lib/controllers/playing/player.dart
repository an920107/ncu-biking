import 'dart:async';
import 'dart:collection';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ncu_biking/controllers/scalable_sprite.dart';
import 'package:ncu_biking/screens/gameover.dart';

class Player extends ScalableSprite with CollisionCallbacks, KeyboardHandler {
  Player({super.coefficient = 0.15});

  final double _forwardSpeed = 800, _backwardSpeed = 500, _offsetSpeed = 5;
  final _hitbox = RectangleHitbox();
  final sprites = Queue<Sprite>();
  late Timer interval;
  double _offset = 0;
  int _offsetDest = 0;
  bool _isMovingForward = false;

  @override
  FutureOr<void> onLoad() async {
    for (int i = 0; i < 3; i++) {
      sprites.add(await Sprite.load("player/player$i.png"));
    }
    sprite = sprites.first;
    anchor = Anchor.center;

    _hitbox.debugColor = Colors.red;
    _hitbox.debugMode = true;

    interval = Timer(
      0.2,
      onTick: () {
        if (sprites.isNotEmpty) {
          sprites.add(sprites.removeFirst());
          sprite = sprites.first;
        }
      },
      repeat: true,
    );
    add(_PositionHitbox(anchor: Anchor.center, children: [_hitbox]));
    return super.onLoad();
  }

  @override
  void onMount() {
    _isMovingForward = false;
    _offset = 0;
    _offsetDest = 0;
    position = _getDefaultPosition();
    onGameResize(gameRef.size);
    super.onMount();
  }

  @override
  void update(double dt) {
    if (!gameRef.isPlaying) {
      super.update(dt);
      return;
    }

    if (_isMovingForward && position.y > gameRef.size.y * 0.1) {
      position.y -= _forwardSpeed * dt * gameRef.scale;
    } else if (position.y < _getDefaultPosition().y) {
      position.y += _backwardSpeed * dt * gameRef.scale;
    } else {
      position.y = _getDefaultPosition().y;
    }

    if (_offsetDest != _offset) {
      if (_offsetDest < _offset) {
        _offset -= _offsetSpeed * dt * gameRef.scale;
        if (_offsetDest >= _offset) {
          _offset = _offsetDest.toDouble();
        }
      } else {
        _offset += _offsetSpeed * dt * gameRef.scale;
        if (_offsetDest <= _offset) {
          _offset = _offsetDest.toDouble();
        }
      }
    }
    position.x = gameRef.size.x / 2 + _offset * 330 * gameRef.scale;

    if (_isMovingForward || position.y >= _getDefaultPosition().y) {
      interval.update(dt);
    }
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    children.whereType<_PositionHitbox>().firstOrNull
      ?..size = Vector2(super.size.x * 0.5, super.size.y)
      ..position = super.size / 2;
    super.onGameResize(size);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (gameRef.isPlaying) {
      if (event is RawKeyDownEvent) {
        if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
          if (_offsetDest == _offset && _offsetDest > -1) _offsetDest--;
        }
        if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
          if (_offsetDest == _offset && _offsetDest < 1) _offsetDest++;
        }
        if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
          _isMovingForward = true;
        }
      } else if (event is RawKeyUpEvent) {
        switch (event.logicalKey) {
          case LogicalKeyboardKey.arrowUp:
            _isMovingForward = false;
            break;
          default:
            break;
        }
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    print("collision");
    parent?.add(GameOver());
    gameRef.isPlaying = false;
    super.onCollisionStart(intersectionPoints, other);
  }

  Vector2 _getDefaultPosition() {
    return Vector2(gameRef.size.x / 2, gameRef.size.y * 0.9);
  }
}

class _PositionHitbox extends PositionComponent with CollisionCallbacks {
  _PositionHitbox({
    super.anchor,
    super.children,
  });

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (parent is CollisionCallbacks) {
      (parent as CollisionCallbacks).onCollision(intersectionPoints, other);
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (parent is CollisionCallbacks) {
      (parent as CollisionCallbacks)
          .onCollisionStart(intersectionPoints, other);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (parent is CollisionCallbacks) {
      (parent as CollisionCallbacks).onCollisionEnd(other);
    }
    super.onCollisionEnd(other);
  }
}
