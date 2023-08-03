import 'package:flame/components.dart';

abstract class SpriteManager {
  // late final Sprite background;
  late final Sprite cover;
  late final Sprite start;
  late final Sprite playerCrashed;
  late final List<Sprite> players;
  late final List<Sprite> birds;
  late final List<Sprite> cars;
  late final List<Sprite> persons;
  late final List<Sprite> buses;
  late final List<Sprite> roads;

  static Future<SpriteManager> load() async {
    return _SpriteManager()
      // ..background = await Sprite.load("cover/background.png")
      ..cover = await Sprite.load("cover/begin.png")
      ..start = await Sprite.load("cover/start.png")
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

  static Future<List<Sprite>> _generateSpritesList(
      int length, Future<Sprite> Function(int index) generator) async {
    final list = <Sprite>[];
    for (int i = 0; i < length; i++) {
      list.add(await generator.call(i));
    }
    return List.unmodifiable(list);
  }
}

class _SpriteManager extends SpriteManager {}
