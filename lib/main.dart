import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' as material;
import 'package:ncu_biking/screens/playing.dart';
import 'package:ncu_biking/screens/title.dart';

void main() {
  material.runApp(GameWidget(game: Main()));
}

class Main extends FlameGame
    with
        HasKeyboardHandlerComponents,
        HasCollisionDetection,
        HasTappablesBridge {
  late final RouterComponent router;
  final double coverWidth = 1120, coverHeight = 2136;
  double scale = 1.0;
  double accumulatedTime = 0.0;
  bool isPlaying = false;

  @override
  FutureOr<void> onLoad() async {
    add(router = RouterComponent(
      initialRoute: "title",
      routes: {
        "title": Route(Title.new),
        "playing": Route(Playing.new),
      },
    ));
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    final double ratio = size.x / size.y;
    final double coverRatio = coverWidth / coverHeight;
    if (ratio > coverRatio) {
      scale = size.y / coverHeight;
    } else {
      scale = size.x / coverWidth;
    }
    super.onGameResize(size);
  }
}
