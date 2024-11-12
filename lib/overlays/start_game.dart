import 'package:flutter/material.dart';
import 'package:ncu_biking/main.dart';

class StartGame extends StatelessWidget {
  const StartGame({
    super.key,
    required this.game,
  });

  final NcuBikingGame game;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        game.overlays
            .removeAll(game.overlays.activeOverlays.toList());
        game.router.pushReplacementNamed("playing");
      },
      child: Container(
        width: game.size.x,
        height: game.size.y,
        color: const Color.fromARGB(0, 0, 0, 0),
      ),
    );
  }
}
