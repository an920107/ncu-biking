import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Route, Title;
import 'package:ncu_biking/overlays/game_over.dart';
import 'package:ncu_biking/overlays/instruction.dart';
import 'package:ncu_biking/overlays/joystick.dart';
import 'package:ncu_biking/overlays/milage_hud.dart';
import 'package:ncu_biking/overlays/start_game.dart';
import 'package:ncu_biking/screens/playing.dart';
import 'package:ncu_biking/screens/title.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

late final GameResizeNotifier gameResizeNotifier;
late final MilageChangeNotifier milageChangeNotifier;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  gameResizeNotifier = GameResizeNotifier();
  milageChangeNotifier = MilageChangeNotifier();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: gameResizeNotifier),
      ChangeNotifierProvider.value(value: milageChangeNotifier),
    ],
    child: MaterialApp(
      title: "NCU Biking",
      home: Scaffold(
        body: GameWidget(
          game: Main(),
          overlayBuilderMap: {
            "start_game": (BuildContext context, Main game) =>
                StartGame(game: game),
            "instruction": (BuildContext context, Main game) =>
                Instruction(game: game),
            "milage_hud": (BuildContext context, Main game) =>
                MilageHud(game: game),
            "joystick": (BuildContext context, Main game) =>
                Joystick(game: game),
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
  final _backgroundSprite = SpriteComponent();

  late final RouterComponent router;
  final double coverWidth = 1120, coverHeight = 2136;
  final double backgroundWidth = 1920, backgroundHeight = 961;
  double scale = 1.0;
  bool isPlaying = false;

  final double baseSpeed = 450;
  final double milageCoefficient = 5E4;
  double milage = 0.0;
  double accumulatedTime = 0.0;

  @override
  FutureOr<void> onLoad() async {
    add(_backgroundSprite
      ..sprite = await Sprite.load("cover/background.png")
      ..anchor = Anchor.center);
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
    final double backgroundRatio = backgroundWidth / backgroundHeight;

    _backgroundSprite.scale = (ratio > backgroundRatio)
        ? Vector2.all(size.x / backgroundWidth)
        : Vector2.all(size.y / backgroundHeight);
    _backgroundSprite.position = size / 2;

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

enum JoystickKey {
  none,
  up,
  left,
  right;
}

enum JoystickKeyEvent {
  none,
  down,
  up;
}

class JoystickChangeNotifier extends ChangeNotifier {
  JoystickKey key = JoystickKey.none;
  JoystickKeyEvent event = JoystickKeyEvent.none;

  void notify(JoystickKey key, JoystickKeyEvent event) {
    this.key = key;
    this.event = event;
    notifyListeners();
  }
}
