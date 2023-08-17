import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' hide Route, Title;
import 'package:flutter/services.dart';
import 'package:ncu_biking/controllers/playing/obstacle.dart';
import 'package:ncu_biking/http_service.dart';
import 'package:ncu_biking/image_manager.dart';
import 'package:ncu_biking/overlays/game_over.dart';
import 'package:ncu_biking/overlays/instruction.dart';
import 'package:ncu_biking/overlays/joystick.dart';
import 'package:ncu_biking/overlays/loading_icon.dart';
import 'package:ncu_biking/overlays/milage_hud.dart';
import 'package:ncu_biking/overlays/start_game.dart';
import 'package:ncu_biking/screens/loading.dart';
import 'package:ncu_biking/screens/playing.dart';
import 'package:ncu_biking/screens/title.dart';
import 'package:ncu_biking/sprite_manager.dart';
import 'package:provider/provider.dart';

late final GameResizeNotifier gameResizeNotifier;
late final MilageChangeNotifier milageChangeNotifier;

Future<void> main() async {
  String? token = Uri.base.queryParameters["token"];
  if (token == "undefined" || token == "null") {
    token = null;
  }

  WidgetsFlutterBinding.ensureInitialized();

  gameResizeNotifier = GameResizeNotifier();
  milageChangeNotifier = MilageChangeNotifier();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: gameResizeNotifier),
      ChangeNotifierProvider.value(value: milageChangeNotifier),
    ],
    child: MaterialApp(
      title: "NCU Biking",
      theme: ThemeData(
          fontFamily: "iansui",
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 117, 135, 158)),
          textTheme: const TextTheme(
            labelLarge: TextStyle(color: Color.fromARGB(255, 117, 135, 158)),
            bodyLarge: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
            bodyMedium: TextStyle(color: Color.fromARGB(150, 255, 255, 255)),
            bodySmall: TextStyle(
              color: Color.fromARGB(150, 255, 255, 255),
              fontStyle: FontStyle.italic,
            ),
          )),
      home: Scaffold(
        body: GameWidget(
          game: Main(token: token),
          overlayBuilderMap: {
            "loading_icon": (BuildContext context, Main game) =>
                LoadingIcon(game: game),
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
          initialActiveOverlays: const ["loading_icon"],
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
  Main({String? token}) {
    httpService = HttpService(
      "https://api.main.ncufresh.ncu.edu.tw",
      token: token,
    );
  }

  late final HttpService httpService;

  final _backgroundSprite = SpriteComponent();

  late final Uint8List faviconImage;
  late final RouterComponent router;
  late final SpriteManager spriteManager;
  late final ImageManager imageManager;
  final double coverWidth = 1120, coverHeight = 2136;
  final double backgroundWidth = 1920, backgroundHeight = 961;
  double scale = 1.0;
  bool isPlaying = false;

  final double baseSpeed = 500;
  final double milageCoefficient = 5E4;
  double milage = 0.0;
  double accumulatedTime = 0.0;
  Obstacle? crashed;

  @override
  FutureOr<void> onLoad() async {
    await Future.wait([
      () async {
        add(_backgroundSprite
          ..sprite = await Sprite.load("cover/background.png")
          ..anchor = Anchor.center);
      }(),
      () async {
        faviconImage =
            (await rootBundle.load("assets/images/cover/favicon.gif"))
                .buffer
                .asUint8List();
      }(),
    ]);

    add(router = RouterComponent(
      initialRoute: "loading",
      routes: {
        "loading": Route(Loading.new),
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
