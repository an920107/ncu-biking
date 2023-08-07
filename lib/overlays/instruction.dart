import 'package:flutter/material.dart';
import 'package:ncu_biking/main.dart';
import 'package:provider/provider.dart';

class Instruction extends StatelessWidget {
  const Instruction({
    super.key,
    required this.game,
  });

  final Main game;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        game.overlays.remove("instruction");
        game.overlays.add("joystick");
        game.isPlaying = true;
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
                  game.imageManager.instruction,
                  width: game.coverWidth * game.scale * 0.8,
                ),
                Positioned(
                  top: 300 * game.scale,
                  child: Text(
                    "遊戲說明",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontFamily: "iansui",
                      fontSize: 120 * game.scale,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Positioned(
                  top: 510 * game.scale,
                  child: Text(
                    "利用鍵盤或螢幕方向鍵移動\n　↑　：向前加速\n←　→：左右移動\n閃避路上的各種障礙物",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontFamily: "iansui",
                      fontSize: 50 * game.scale,
                      height: 1.4,
                    ),
                  ),
                ),
                Positioned(
                  top: 900 * game.scale,
                  child: Text(
                    "風和日麗的午後\n在環校道路上騎著腳踏車\n是多麼愜意的一件事...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(160, 255, 255, 255),
                      fontFamily: "iansui",
                      fontSize: 40 * game.scale,
                      fontStyle: FontStyle.italic,
                      height: 1.3,
                    ),
                  ),
                ),
                Positioned(
                  top: 1100 * game.scale,
                  child: Text(
                    "《點擊任意區域開始遊戲》",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(160, 255, 255, 255),
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
