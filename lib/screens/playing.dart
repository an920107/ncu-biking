import 'dart:async';

import 'package:flame/components.dart';
import 'package:ncu_biking/controllers/playing/obstacle/bird.dart';
import 'package:ncu_biking/controllers/playing/obstacle/bus.dart';
import 'package:ncu_biking/controllers/playing/obstacle/car.dart';
import 'package:ncu_biking/controllers/playing/obstacle/person.dart';
import 'package:ncu_biking/controllers/playing/player.dart';
import 'package:ncu_biking/controllers/playing/roads.dart';
import 'package:ncu_biking/main.dart';

class Playing extends Component with HasGameRef<Main> {
  @override
  FutureOr<void> onLoad() async {
    addAll([
      Roads(),
      Player(),
      // Car(),
      // Bird(),
      // Bus(),
      Person(),
    ]);
    return super.onLoad();
  }

  @override
  void onMount() {
    print("mounting");
    gameRef.isPlaying = true;
    gameRef.accumulatedTime = 0.0;
    super.onMount();
  }

  @override
  void update(double dt) {
    if (gameRef.isPlaying) {
      gameRef.accumulatedTime += dt;
      print(gameRef.accumulatedTime);
    }
    super.update(dt);
  }
}
