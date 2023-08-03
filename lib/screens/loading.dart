import 'dart:async';

import 'package:flame/components.dart';
import 'package:ncu_biking/image_manager.dart';
import 'package:ncu_biking/main.dart';
import 'package:ncu_biking/sprite_manager.dart';

class Loading extends Component with HasGameRef<Main> {
  @override
  FutureOr<void> onLoad() async {
    SpriteManager.load().then((value) {
      gameRef.spriteManager = value;
      ImageManager.load().then((value) {
        gameRef.imageManager = value;
        gameRef.router.pushReplacementNamed("title");
        gameRef.overlays.clear();
      });
    });
    return super.onLoad();
  }
}
