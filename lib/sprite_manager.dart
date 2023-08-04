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
      () async {
        manager.cover = await Sprite.load("cover/begin.png");
      }(),
      () async {
        manager.start = await Sprite.load("cover/start.png");
      }(),
      () async {
        manager.playerCrashed = await Sprite.load("player/be_crashed.png");
      }(),
      () async {
        manager.players = await _generateSpritesList(
            3, (index) => Sprite.load("player/player$index.png"));
      }(),
      () async {
        manager.birds = await _generateSpritesList(
            4, (index) => Sprite.load("bird/bird$index.png"));
      }(),
      () async {
        manager.cars = await _generateSpritesList(
            3, (index) => Sprite.load("car/car$index.png"));
      }(),
      () async {
        manager.buses = await _generateSpritesList(
            6, (index) => Sprite.load("bus/bus$index.png"));
      }(),
      () async {
        manager.persons = await _generateSpritesList(
            4, (index) => Sprite.load("person/person_v2-$index.png"));
      }(),
      () async {
        manager.roads = await _generateSpritesList(
            4, (index) => Sprite.load("road/road$index.png"));
      }(),
    ]);

    return manager;
  }

  static Future<List<Sprite>> _generateSpritesList(
      int length, Future<Sprite> Function(int index) generator) async {
    final List<Sprite?> spriteList = List.filled(length, null);
    await Future.wait(List.generate(
        length,
        (index) => () async {
              spriteList[index] = await generator.call(index);
            }()));
    return List.unmodifiable(spriteList);
  }
}

class _SpriteManager extends SpriteManager {}
