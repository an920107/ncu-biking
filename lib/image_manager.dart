import 'package:flutter/services.dart';

abstract class ImageManager {
  late final Uint8List instruction;
  late final Uint8List gameOver;

  static Future<ImageManager> load() async {
    return _ImageManager()
      ..instruction =
          (await rootBundle.load("assets/images/cover/instruction.png"))
              .buffer
              .asUint8List()
      ..gameOver =
          (await rootBundle.load("assets/images/cover/game_over.png"))
              .buffer
              .asUint8List();
  }
}

class _ImageManager extends ImageManager {}
