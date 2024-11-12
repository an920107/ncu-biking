import 'package:flutter/services.dart';

abstract class ImageManager {
  late final Uint8List instruction;
  late final Uint8List gameOver;

  static Future<ImageManager> load() async {
    final manager = _ImageManager();

    await Future.wait([
      rootBundle
          .load("assets/images/cover/instruction.png")
          .then((data) => manager.instruction = data.buffer.asUint8List()),
      rootBundle.load("assets/images/cover/game_over.png").then((data) => manager.gameOver = data.buffer.asUint8List()),
    ]);

    return manager;
  }
}

class _ImageManager extends ImageManager {}
