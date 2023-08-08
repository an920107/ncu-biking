import 'package:flutter/material.dart';
import 'package:ncu_biking/controllers/playing/obstacle.dart';
import 'package:ncu_biking/controllers/playing/obstacle/bird.dart';
import 'package:ncu_biking/controllers/playing/obstacle/bus.dart';
import 'package:ncu_biking/controllers/playing/obstacle/car.dart';
import 'package:ncu_biking/controllers/playing/obstacle/person.dart';
import 'package:ncu_biking/main.dart';
import 'package:provider/provider.dart';

class GameOver extends StatefulWidget {
  const GameOver({
    super.key,
    required this.game,
  });

  final Main game;

  @override
  State<GameOver> createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  bool _canEscape = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1)).then((_) {
      if (context.mounted) {
        setState(() => _canEscape = true);
      }
    });

    // widget.game.httpService
    //     .get("https://api.game.ncufresh.ncu.edu.tw/user/nickname")
    //     .then((value) {
    //   print(value.data);
    // });

    return GestureDetector(
      onTap: _canEscape
          ? () {
              widget.game.overlays
                  .removeAll(widget.game.overlays.activeOverlays.toList());
              widget.game.router.pushReplacementNamed("title");
            }
          : null,
      child: Consumer<GameResizeNotifier>(
        builder: (context, value, child) => Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: widget.game.size.x,
              height: widget.game.size.y,
              color: const Color.fromARGB(0, 0, 0, 0),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.memory(
                  widget.game.imageManager.gameOver,
                  width: widget.game.coverWidth * widget.game.scale * 0.7,
                ),
                Positioned(
                  top: 320 * widget.game.scale,
                  child: Text(
                    "死因: ${_causeOfDeath(widget.game.crashed)}\nmilage: ${(widget.game.milage / widget.game.milageCoefficient).toStringAsFixed(2)} km\ntime: ${widget.game.accumulatedTime.toStringAsFixed(1)} s",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 55 * widget.game.scale,
                          height: 1.3,
                        ),
                  ),
                ),
                if (_canEscape)
                  Positioned(
                    top: 660 * widget.game.scale,
                    child: Text(
                      "　　　　　　《點擊任意區域繼續》",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 40 * widget.game.scale,
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

  String _causeOfDeath(Obstacle? obstacle) {
    if (obstacle is Bus) return "超速公車";
    if (obstacle is Car) return "違停車輛";
    if (obstacle is Person) return "白目行人";
    if (obstacle is Bird) return "笨笨烏秋";
    return "error";
  }
}
