import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:ncu_biking/controllers/scalable_sprite.dart';

class Obstacle extends ScalableSprite {
  Obstacle({
    required super.coefficient,
    double relativeX = 1.0,
    double relativeY = 1.0,
  }) : relative = Vector2(relativeX, relativeY);

  final Vector2 relative;
  final _hitbox = RectangleHitbox();

  @override
  FutureOr<void> onLoad() {
    _hitbox.debugColor = Colors.green;
    _hitbox.debugMode = true;
    add(PositionComponent(
      anchor: Anchor.center,
      children: [_hitbox],
    ));
    return super.onLoad();
  }

  @override
  void onMount() {
    onGameResize(gameRef.size);
    super.onMount();
  }

  @override
  void onGameResize(Vector2 size) {
    children.whereType<PositionComponent>().firstOrNull
      ?..size = Vector2(super.size.x * relative.x, super.size.y * relative.y)
      ..position = super.size / 2;
    super.onGameResize(size);
  }

  @override
  void onRemove() {
    if (parent != null) removeFromParent();
    super.onRemove();
  }
}
