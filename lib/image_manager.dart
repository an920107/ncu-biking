import 'package:flutter/services.dart';

abstract class ImageManager {
  late final Uint8List instruction;
  late final Uint8List gameOver;

  static Future<ImageManager> load() async {
    final manager = _ImageManager();

    await Future.wait([
      () async {
        manager.instruction =
            (await rootBundle.load("assets/images/cover/instruction.png"))
                .buffer
                .asUint8List();
      }(),
      () async {
        manager.gameOver =
            (await rootBundle.load("assets/images/cover/game_over.png"))
                .buffer
                .asUint8List();
      }(),
    ]);

    return manager;
  }
}

class _ImageManager extends ImageManager {}
