import 'dart:async';

import 'package:flame/components.dart';
import 'package:ncu_biking/asset_manager/image_manager.dart';
import 'package:ncu_biking/main.dart';
import 'package:ncu_biking/asset_manager/sprite_manager.dart';

class Loading extends Component with HasGameRef<NcuBikingGame> {
  @override
  FutureOr<void> onLoad() async {
    await Future.wait([
      SpriteManager.load().then((spriteManager) => gameRef.spriteManager = spriteManager),
      ImageManager.load().then((imageManager) => gameRef.imageManager = imageManager),
    ]);
    gameRef.overlays.clear();
    gameRef.router.pushReplacementNamed("title");
    return super.onLoad();
  }
}
