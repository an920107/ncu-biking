import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:ncu_biking/controllers/playing/obstacle/obstacle.dart';

class Bus extends Obstacle {
  Bus({
    super.coefficient = 0.3,
    super.relativeX = 0.9,
    super.relativeY = 0.6,
  });

  final sprites = Queue<Sprite>();
  late Timer interval;

  @override
  FutureOr<void> onLoad() async {
    for (int i = 0; i < 6; i++) {
      sprites.add(await Sprite.load("bus/bus$i.png"));
    }
    sprite = sprites.first;
    anchor = Anchor.center;
    angle = pi / 180 * 90;
    position = Vector2(gameRef.size.x / 2, gameRef.size.x / 2);

    interval = Timer(
      0.3,
      onTick: () {
        if (sprites.isNotEmpty) {
          sprites.add(sprites.removeFirst());
          sprite = sprites.first;
        }
      },
      repeat: true,
    );
    return super.onLoad();
  }

  @override
  void update(double dt) {
    interval.update(dt);
    super.update(dt);
  }
}
