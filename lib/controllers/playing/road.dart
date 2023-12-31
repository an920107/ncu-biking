import 'package:flame/components.dart';
import 'package:ncu_biking/controllers/scalable_sprite.dart';

class Road extends ScalableSprite {
  Road({
    super.coefficient = 1.0,
    required super.sprite,
    this.linked,
    dynamic Function()? onArrived,
  }) : _onArrived = onArrived;

  final Function()? _onArrived;
  Road? linked;

  late final double _speed = gameRef.baseSpeed;

  @override
  void update(double dt) {
    if (gameRef.isPlaying) {
      if (linked == null) {
        position.y += dt * _speed * gameRef.scale;
        if (position.y > gameRef.size.y + size.y) {
          if (_onArrived != null) _onArrived!.call();
        }
      } else {
        position.y = linked!.y - linked!.size.y + dt * _speed * gameRef.scale;
      }
    }
    super.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    position.x = gameRef.size.x / 2;
    super.onGameResize(size);
  }
}
