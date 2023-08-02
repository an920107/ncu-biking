import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ncu_biking/main.dart';

class Joystick extends StatelessWidget {
  const Joystick({
    super.key,
    required this.game,
  });

  final Main game;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          bottom: 50 * game.scale,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => game.onKeyEvent(
                  const RawKeyDownEvent(
                    data: RawKeyEventDataWeb(
                      code: "ArrowLeft",
                      key: "ArrowLeft",
                      metaState: 0,
                      keyCode: 37,
                    ),
                  ),
                  {LogicalKeyboardKey.arrowLeft},
                ),
                iconSize: 200 * game.scale,
                icon: const Icon(
                  Icons.arrow_circle_left_outlined,
                  color: Color.fromARGB(80, 0, 0, 0),
                ),
              ),
              SizedBox(width: 100 * game.scale),
              GestureDetector(
                onTapDown: (detial) => game.onKeyEvent(
                  const RawKeyDownEvent(
                    data: RawKeyEventDataWeb(
                      code: "ArrowUp",
                      key: "ArrowUp",
                      metaState: 0,
                      keyCode: 38,
                    ),
                  ),
                  {LogicalKeyboardKey.arrowUp},
                ),
                onTapCancel: () => game.onKeyEvent(
                  const RawKeyUpEvent(
                    data: RawKeyEventDataWeb(
                      code: "ArrowUp",
                      key: "ArrowUp",
                      metaState: 0,
                      keyCode: 38,
                    ),
                  ),
                  {LogicalKeyboardKey.arrowUp},
                ),
                child: IconButton(
                  onPressed: () {},
                  iconSize: 200 * game.scale,
                  icon: const Icon(
                    Icons.arrow_circle_up,
                    color: Color.fromARGB(80, 0, 0, 0),
                  ),
                ),
              ),
              SizedBox(width: 100 * game.scale),
              IconButton(
                onPressed: () => game.onKeyEvent(
                  const RawKeyDownEvent(
                    data: RawKeyEventDataWeb(
                      code: "ArrowRight",
                      key: "ArrowRight",
                      metaState: 0,
                      keyCode: 39,
                    ),
                  ),
                  {LogicalKeyboardKey.arrowRight},
                ),
                iconSize: 200 * game.scale,
                icon: const Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Color.fromARGB(80, 0, 0, 0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
