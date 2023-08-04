import 'dart:async';

import 'package:flame/components.dart';
import 'package:ncu_biking/image_manager.dart';
import 'package:ncu_biking/main.dart';
import 'package:ncu_biking/sprite_manager.dart';

class Loading extends Component with HasGameRef<Main> {
  @override
  FutureOr<void> onLoad() async {
    await Future.wait([
      () async {
        gameRef.spriteManager = await SpriteManager.load();
      }(),
      () async {
        gameRef.imageManager = await ImageManager.load();
      }(),
    ]);
    gameRef.overlays.clear();
    gameRef.router.pushReplacementNamed("title");
    return super.onLoad();
  }
}
