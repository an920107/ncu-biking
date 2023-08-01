import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:ncu_biking/controllers/scalable_sprite.dart';
import 'package:ncu_biking/main.dart';

class GameOver extends Component with HasGameRef<Main>, TapCallbacks {
  final _overlay = ScalableSprite(coefficient: 0.8);

  @override
  FutureOr<void> onLoad() async {
    _overlay
      ..sprite = await Sprite.load("cover/game_over.png")
      ..anchor = Anchor.center;
    add(_overlay);
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    _overlay.position = gameRef.size / 2;
    super.onGameResize(size);
  }

  @override
  bool containsLocalPoint(Vector2 point) {
    return true;
  }

  @override
  void onTapDown(TapDownEvent event) {
    removeFromParent();
    gameRef.router.popUntilNamed("title");
    super.onTapDown(event);
  }
}
