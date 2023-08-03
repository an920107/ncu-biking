import 'package:flame/components.dart';

abstract class SpritesManager {
  // late final Sprite background;
  late final Sprite cover;
  late final Sprite start;
  late final Sprite instruction;
  late final Sprite gameOver;
  late final Sprite playerCrashed;
  late final Iterable<Sprite> players;
  late final Iterable<Sprite> birds;
  late final Iterable<Sprite> cars;
  late final Iterable<Sprite> persons;
  late final Iterable<Sprite> buses;
  late final Iterable<Sprite> roads;

  static Future<SpritesManager> load() async {
    return _SpritesManager()
      // ..background = await Sprite.load("cover/background.png")
      ..cover = await Sprite.load("cover/begin.png")
      ..start = await Sprite.load("cover/start.png")
      ..instruction = await Sprite.load("cover/instruction.png")
      ..gameOver = await Sprite.load("cover/game_over.png")
      ..playerCrashed = await Sprite.load("player/be_crashed.png")
      ..players = await _generateSpritesList(
          3, (index) => Sprite.load("player/player$index.png"))
      ..birds = await _generateSpritesList(
          4, (index) => Sprite.load("bird/bird$index.png"))
      ..cars = await _generateSpritesList(
          3, (index) => Sprite.load("car/car$index.png"))
      ..buses = await _generateSpritesList(
          6, (index) => Sprite.load("bus/bus$index.png"))
      ..persons = await _generateSpritesList(
          4, (index) => Sprite.load("person/person_v2-$index.png"))
      ..roads = await _generateSpritesList(
          4, (index) => Sprite.load("road/road$index.png"));
  }

  static Future<Iterable<Sprite>> _generateSpritesList(
      int length, Future<Sprite> Function(int index) generator) async {
    final list = <Sprite>[];
    for (int i = 0; i < length; i++) {
      list.add(await generator.call(i));
    }
    return List.unmodifiable(list);
  }
}

class _SpritesManager extends SpritesManager {}
