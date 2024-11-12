import 'package:flame/components.dart';
import 'package:ncu_biking/main.dart';

class ScalableSprite extends SpriteComponent with HasGameReference<NcuBikingGame> {
  ScalableSprite({
    required this.coefficient,
    super.sprite,
  });

  final double coefficient;

  @override
  void onGameResize(Vector2 size) {
    super.size = (sprite?.originalSize ?? Vector2.zero()) *
        (game.scale * coefficient * (game.coverWidth / (sprite?.originalSize ?? Vector2.zero()).x));
    super.onGameResize(size);
  }
}
