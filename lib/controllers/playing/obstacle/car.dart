import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:ncu_biking/controllers/playing/obstacle/obstacle.dart';

class Car extends Obstacle {
  Car({
    super.coefficient = 0.3,
    super.relativeY = 0.6,
  });

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load("car/car${Random().nextInt(3)}.png");
    anchor = Anchor.center;
    angle = pi / 180 * 90;
    position = Vector2(gameRef.size.x / 2, gameRef.size.x / 2);
    return super.onLoad();
  }
}
