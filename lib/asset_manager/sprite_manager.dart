import 'package:flame/components.dart';

abstract class SpriteManager {
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
    final manager = _SpriteManager();

    await Future.wait([
      Sprite.load("cover/begin.png").then((sprite) => manager.cover = sprite),
      Sprite.load("cover/start.png").then((sprite) => manager.start = sprite),
      Sprite.load("player/be_crashed.png").then((sprite) => manager.playerCrashed = sprite),
      _generateSpritesList(3, (index) => Sprite.load("player/player$index.png"))
          .then((sprites) => manager.players = sprites),
      _generateSpritesList(4, (index) => Sprite.load("bird/bird$index.png")).then((sprites) => manager.birds = sprites),
      _generateSpritesList(3, (index) => Sprite.load("car/car$index.png")).then((sprites) => manager.cars = sprites),
      _generateSpritesList(6, (index) => Sprite.load("bus/bus$index.png")).then((sprites) => manager.buses = sprites),
      _generateSpritesList(4, (index) => Sprite.load("person/person_v2-$index.png"))
          .then((sprites) => manager.persons = sprites),
      _generateSpritesList(4, (index) => Sprite.load("road/road$index.png")).then((sprites) => manager.roads = sprites),
    ]);

    return manager;
  }

  static Future<List<Sprite>> _generateSpritesList(int length, Future<Sprite> Function(int index) generator) async {
    final List<Sprite?> spriteList = List.filled(length, null);
    await Future.wait(List.generate(length, (index) => generator(index).then((sprite) => spriteList[index] = sprite)));
    return List.unmodifiable(spriteList);
  }
}

class _SpriteManager extends SpriteManager {}
