import 'dart:async';
import 'dart:collection';

import 'package:flame/components.dart';
import 'package:ncu_biking/controllers/playing/obstacle/obstacle.dart';

class Person extends Obstacle {
  Person({
    super.coefficient = 0.1,
    super.relativeX = 0.4,
  });

  final sprites = Queue<Sprite>();
  late Timer interval;

  @override
  FutureOr<void> onLoad() async {
    for (int i = 0; i < 4; i++) {
      sprites.add(await Sprite.load("person/person_v2-$i.png"));
    }
    sprite = sprites.first;
    anchor = Anchor.center;
    position = Vector2(gameRef.size.x / 2, gameRef.size.x / 2);

    interval = Timer(
      0.25,
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
