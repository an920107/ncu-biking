import 'dart:async';
import 'dart:collection';

import 'package:flame/components.dart';
import 'package:ncu_biking/controllers/playing/road.dart';
import 'package:ncu_biking/main.dart';

class Roads extends Component with HasGameReference<NcuBikingGame> {
  final roads = Queue<Road>();

  @override
  FutureOr<void> onLoad() async {
    for (int i = 0; i < 4; i++) {
      roads.add(Road(
        sprite: game.spriteManager.roads[i],
        linked: roads.lastOrNull,
        onArrived: () {
          remove(roads.first);
          roads.first.linked = roads.last;
          roads.add(roads.removeFirst());
          roads.first.linked = null;
          roads.first.y = game.size.y;
          add(roads.elementAt(1));
        },
      )
        ..anchor = Anchor.bottomCenter
        ..x = game.size.x / 2
        ..y = game.size.y);

      if (i < 2) {
        add(roads.last);
      }
    }
    return super.onLoad();
  }
}
