import 'dart:async';
import 'dart:collection';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ncu_biking/controllers/playing/obstacle.dart';
import 'package:ncu_biking/controllers/scalable_sprite.dart';
import 'package:ncu_biking/main.dart';

class Player extends ScalableSprite with CollisionCallbacks, KeyboardHandler {
  Player({super.coefficient = 0.12});

  late final double _forwardSpeed = game.baseSpeed + 300;
  late final double _backwardSpeed = game.baseSpeed;
  final double _offsetSpeed = 5;
  final _hitbox = RectangleHitbox();
  final _sprites = Queue<Sprite>();
  late Timer animationTimer;
  double _offset = 0;
  int _offsetDest = 0;
  bool _isMovingForward = false;

  @override
  FutureOr<void> onLoad() async {
    for (int i = 0; i < 3; i++) {
      _sprites.add(game.spriteManager.players[i]);
    }
    sprite = _sprites.first;
    anchor = Anchor.center;

    if (kDebugMode) {
      _hitbox.debugColor = Colors.red;
      _hitbox.debugMode = true;
      _hitbox.isSolid = true;
    }

    animationTimer = Timer(
      0.2,
      onTick: () {
        if (_sprites.isNotEmpty) {
          _sprites.add(_sprites.removeFirst());
          sprite = _sprites.first;
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
    onGameResize(game.size);
    super.onMount();
  }

  @override
  void update(double dt) {
    position.x = game.size.x / 2 + _offset * 330 * game.scale;

    if (!game.isPlaying) {
      super.update(dt);
      return;
    }

    if (_isMovingForward && position.y > game.size.y * 0.15) {
      position.y -= _forwardSpeed * dt * game.scale;
      game.milage += dt * _forwardSpeed;
      milageChangeNotifier.notify();
    } else if (position.y < _getDefaultPosition().y) {
      position.y += _backwardSpeed * dt * game.scale;
    } else {
      position.y = _getDefaultPosition().y;
      game.milage += dt * _backwardSpeed;
      milageChangeNotifier.notify();
    }

    if (_offsetDest != _offset) {
      if (_offsetDest < _offset) {
        _offset -= _offsetSpeed * dt * game.scale;
        if (_offsetDest >= _offset) {
          _offset = _offsetDest.toDouble();
        }
      } else {
        _offset += _offsetSpeed * dt * game.scale;
        if (_offsetDest <= _offset) {
          _offset = _offsetDest.toDouble();
        }
      }
    }

    if (_isMovingForward || position.y >= _getDefaultPosition().y) {
      animationTimer.update(dt);
    }
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    children.whereType<_PositionHitbox>().firstOrNull
      ?..size = Vector2(super.size.x * 0.5, super.size.y * 0.9)
      ..position = super.size / 2;
    super.onGameResize(size);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (game.isPlaying) {
      if (event is KeyDownEvent) {
        switch (event.logicalKey) {
          case LogicalKeyboardKey.arrowLeft:
          case LogicalKeyboardKey.keyA:
            _leftKeyDown();
            break;
          case LogicalKeyboardKey.arrowRight:
          case LogicalKeyboardKey.keyD:
            _rightKeyDown();
            break;
          case LogicalKeyboardKey.arrowUp:
          case LogicalKeyboardKey.keyW:
            _upKeyDown();
            break;
          default:
            break;
        }
      } else if (event is KeyUpEvent) {
        switch (event.logicalKey) {
          case LogicalKeyboardKey.arrowUp:
          case LogicalKeyboardKey.keyW:
            _upKeyUp();
            break;
          default:
            break;
        }
      }
    }
    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    try {
      game.crashed = other.parent as Obstacle;
    } catch (e) {
      game.crashed = null;
    }
    game.overlays.add("game_over");
    game.isPlaying = false;
    super.onCollisionStart(intersectionPoints, other);
  }

  void _leftKeyDown() {
    if (_offsetDest == _offset && _offsetDest > -1) _offsetDest--;
  }

  void _rightKeyDown() {
    if (_offsetDest == _offset && _offsetDest < 1) _offsetDest++;
  }

  void _upKeyDown() {
    _isMovingForward = true;
  }

  void _upKeyUp() {
    _isMovingForward = false;
  }

  Vector2 _getDefaultPosition() {
    return Vector2(game.size.x / 2, game.size.y * 0.9);
  }
}

class _PositionHitbox extends PositionComponent with CollisionCallbacks {
  _PositionHitbox({
    super.anchor,
    super.children,
  });

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (parent case final CollisionCallbacks parent) {
      parent.onCollision(intersectionPoints, other);
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (parent case final CollisionCallbacks parent) {
      parent.onCollisionStart(intersectionPoints, other);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if (parent case final CollisionCallbacks parent) {
      parent.onCollisionEnd(other);
    }
    super.onCollisionEnd(other);
  }
}
