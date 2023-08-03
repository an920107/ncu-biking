import 'dart:async';

import 'package:flame/components.dart';
import 'package:ncu_biking/main.dart';
import 'package:ncu_biking/sprites_manager.dart';

class Loading extends Component with HasGameRef<Main> {
  @override
  FutureOr<void> onLoad() async {
    gameRef.overlays.add("loading_icon");
    SpritesManager.load().then((value) {
      gameRef.sprites = value;
      gameRef.router.pushReplacementNamed("title");
      gameRef.overlays.clear();
    });

    return super.onLoad();
  }
}
