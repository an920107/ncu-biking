import 'package:flutter/material.dart';
import 'package:ncu_biking/main.dart';
import 'package:provider/provider.dart';

class GameOver extends StatelessWidget {
  const GameOver({
    super.key,
    required this.game,
  });

  final Main game;

  @override
  Widget build(BuildContext context) {
    game.httpService.get("https://api.game.ncufresh.ncu.edu.tw/user/nickname").then((value) {
      print(value.data);
    });
    return GestureDetector(
      onTap: () {
        game.overlays.removeAll(game.overlays.activeOverlays.toList());
        game.router.pushReplacementNamed("title");
      },
      child: Consumer<GameResizeNotifier>(
        builder: (context, value, child) => Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: game.size.x,
              height: game.size.y,
              color: const Color.fromARGB(0, 0, 0, 0),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.memory(
                  game.imageManager.gameOver,
                  width: game.coverWidth * game.scale * 0.7,
                ),
                Positioned(
                  top: 320 * game.scale,
                  child: Text(
                    "milage: ${(game.milage / game.milageCoefficient).toStringAsFixed(2)} km\ntime: ${game.accumulatedTime.toStringAsFixed(1)} s",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontFamily: "iansui",
                      fontSize: 80 * game.scale,
                      height: 1.3,
                    ),
                  ),
                ),
                Positioned(
                  top: 660 * game.scale,
                  child: Text(
                    "　　　　　　《點擊任意區域繼續》",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(150, 255, 255, 255),
                      fontFamily: "iansui",
                      fontSize: 40 * game.scale,
                      height: 1.3,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
