import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Route, Title;
import 'package:ncu_biking/overlays/game_over.dart';
import 'package:ncu_biking/overlays/milage_hud.dart';
import 'package:ncu_biking/overlays/start_game.dart';
import 'package:ncu_biking/screens/playing.dart';
import 'package:ncu_biking/screens/title.dart';
import 'package:provider/provider.dart';

late final GameResizeNotifier gameResizeNotifier;
late final MilageChangeNotifier milageChangeNotifier;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  gameResizeNotifier = GameResizeNotifier();
  milageChangeNotifier = MilageChangeNotifier();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: gameResizeNotifier),
      ChangeNotifierProvider.value(value: milageChangeNotifier),
    ],
    child: MaterialApp(
      home: Scaffold(
        body: GameWidget(
          game: Main(),
          overlayBuilderMap: {
            "start_game": (BuildContext context, Main game) =>
                StartGame(game: game),
            "milage_hud": (BuildContext context, Main game) =>
                MilageHud(game: game),
            "game_over": (BuildContext context, Main game) =>
                GameOver(game: game),
          },
        ),
      ),
    ),
  ));
}

class Main extends FlameGame
    with
        HasKeyboardHandlerComponents,
        HasCollisionDetection,
        HasTappablesBridge {
  late final RouterComponent router;
  final double coverWidth = 1120, coverHeight = 2136;
  double scale = 1.0;
  bool isPlaying = false;

  final double baseSpeed = 500;
  final double milageCoefficient = 5E4;
  double milage = 0.0;
  double accumulatedTime = 0.0;

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
    gameResizeNotifier.notify(size);
  }
}

class GameResizeNotifier extends ChangeNotifier {
  Vector2 _lastSize = Vector2.zero();

  void notify(Vector2 size) {
    if (_lastSize != size) {
      _lastSize = size;
      Future.delayed(Duration.zero, () => notifyListeners());
    }
  }
}

class MilageChangeNotifier extends ChangeNotifier {
  void notify() {
    Future.delayed(Duration.zero, () => notifyListeners());
  }
}
