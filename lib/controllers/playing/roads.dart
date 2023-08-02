import 'dart:async';
import 'dart:collection';

import 'package:flame/components.dart';
import 'package:ncu_biking/controllers/playing/road.dart';
import 'package:ncu_biking/main.dart';

class Roads extends Component with HasGameRef<Main> {
  final roads = Queue<Road>();

  @override
  FutureOr<void> onLoad() async {
    for (int i = 0; i < 4; i++) {
      roads.add(Road(
        sprite: await Sprite.load("road/road$i.png"),
        linked: roads.lastOrNull,
        onArrived: () {
          remove(roads.first);
          roads.first.linked = roads.last;
          roads.add(roads.removeFirst());
          roads.first.linked = null;
          roads.first.y = gameRef.size.y;
          add(roads.elementAt(1));
        },
      )
        ..anchor = Anchor.bottomCenter
        ..x = gameRef.size.x / 2
        ..y = gameRef.size.y);

      if (i < 2) {
        add(roads.last);
      }
    }
    return super.onLoad();
  }
}
