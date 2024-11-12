import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:ncu_biking/main.dart';

class Title extends Component with HasGameRef<NcuBikingGame> {
  final _cover = SpriteComponent();
  final _startButton = SpriteButtonComponent();

  @override
  FutureOr<void> onLoad() async {
    _cover.sprite = gameRef.spriteManager.cover;
    add(_cover);

    _startButton
      ..button = gameRef.spriteManager.start
      ..onPressed = () {
        gameRef.router.pushNamed("playing");
      };
    _cover.add(_startButton);

    return super.onLoad();
  }

  @override
  void onMount() {
    gameRef.overlays.add("start_game");
    super.onMount();
  }

  @override
  void onGameResize(Vector2 size) {
    _cover
      ..size = (_cover.sprite?.originalSize ?? Vector2.zero()) * gameRef.scale
      ..anchor = Anchor.center
      ..position = Vector2(size.x, size.y) / 2;

    const double buttonWidth = 808, buttonHeight = 121;
    _startButton
      ..size = Vector2(buttonWidth, buttonHeight) * gameRef.scale
      ..anchor = Anchor.topLeft
      ..position = Vector2(199, 268) * gameRef.scale;
    super.onGameResize(size);
  }
}
