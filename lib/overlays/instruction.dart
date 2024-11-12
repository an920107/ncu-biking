import 'package:flutter/material.dart';
import 'package:ncu_biking/main.dart';
import 'package:provider/provider.dart';

class Instruction extends StatefulWidget {
  const Instruction({
    super.key,
    required this.game,
  });

  final NcuBikingGame game;

  @override
  State<Instruction> createState() => _InstructionState();
}

class _InstructionState extends State<Instruction> {
  bool _canEscape = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500)).then((_) {
      if (context.mounted) {
        setState(() => _canEscape = true);
      }
    });

    return GestureDetector(
      onTap: _canEscape
          ? () {
              widget.game.overlays.remove("instruction");
              widget.game.overlays.add("joystick");
              widget.game.isPlaying = true;
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
                  widget.game.imageManager.instruction,
                  width: widget.game.coverWidth * widget.game.scale * 0.8,
                ),
                Positioned(
                  top: 300 * widget.game.scale,
                  child: Text(
                    "遊戲說明",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 120 * widget.game.scale,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ),
                Positioned(
                  top: 520 * widget.game.scale,
                  child: Text(
                    "利用\"鍵盤\"或\"螢幕方向鍵\"移動\n　↑　：向前加速\n←　→：左右移動\n閃避路上的各種障礙物",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 48 * widget.game.scale,
                          height: 1.4,
                        ),
                  ),
                ),
                Positioned(
                  top: 900 * widget.game.scale,
                  child: Text(
                    "風和日麗的午後\n在環校道路上騎著腳踏車\n是多麼愜意的一件事...",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 40 * widget.game.scale,
                          height: 1.3,
                        ),
                  ),
                ),
                if (_canEscape)
                  Positioned(
                    top: 1100 * widget.game.scale,
                    child: Text(
                      "《點擊任意區域開始遊戲》",
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
}
