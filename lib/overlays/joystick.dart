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
          bottom: 80 * game.scale,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 180 * game.scale,
                height: 300 * game.scale,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20 * game.scale),
                  color: const Color.fromARGB(100, 255, 255, 255),
                ),
                child: GestureDetector(
                  onTapDown: (details) => game.onKeyEvent(
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
                  child: Icon(
                    Icons.chevron_left,
                    size: 150 * game.scale,
                    color: const Color.fromARGB(255, 117, 135, 158),
                  ),
                ),
              ),
              SizedBox(width: 40 * game.scale),
              Container(
                width: 180 * game.scale,
                height: 300 * game.scale,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20 * game.scale),
                  color: const Color.fromARGB(100, 255, 255, 255),
                ),
                child: GestureDetector(
                  onTapDown: (details) => game.onKeyEvent(
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
                  child: Icon(
                    Icons.chevron_right,
                    size: 150 * game.scale,
                    color: const Color.fromARGB(255, 117, 135, 158),
                  ),
                ),
              ),
              SizedBox(width: 200 * game.scale),
              Container(
                width: 300 * game.scale,
                height: 300 * game.scale,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20 * game.scale),
                  color: const Color.fromARGB(100, 255, 255, 255),
                ),
                child: GestureDetector(
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
                  onTapUp: (detail) => game.onKeyEvent(
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
                  child: Icon(
                    Icons.speed,
                    size: 150 * game.scale,
                    color: const Color.fromARGB(255, 117, 135, 158),
                  ),
                ),
              ),
              // IconButton(
              //   onPressed: () => game.onKeyEvent(
              //     const RawKeyDownEvent(
              //       data: RawKeyEventDataWeb(
              //         code: "ArrowLeft",
              //         key: "ArrowLeft",
              //         metaState: 0,
              //         keyCode: 37,
              //       ),
              //     ),
              //     {LogicalKeyboardKey.arrowLeft},
              //   ),
              //   iconSize: 250 * game.scale,
              //   icon: const Icon(
              //     Icons.chevron_left,
              //     color: Color.fromARGB(80, 0, 0, 0),
              //   ),
              // ),
              // IconButton(
              //   onPressed: () => game.onKeyEvent(
              //     const RawKeyDownEvent(
              //       data: RawKeyEventDataWeb(
              //         code: "ArrowRight",
              //         key: "ArrowRight",
              //         metaState: 0,
              //         keyCode: 39,
              //       ),
              //     ),
              //     {LogicalKeyboardKey.arrowRight},
              //   ),
              //   iconSize: 250 * game.scale,
              //   icon: const Icon(
              //     Icons.chevron_right,
              //     color: Color.fromARGB(80, 0, 0, 0),
              //   ),
              // ),
              // SizedBox(width: 100 * game.scale),
              // GestureDetector(
              //   onTapDown: (detial) => game.onKeyEvent(
              //     const RawKeyDownEvent(
              //       data: RawKeyEventDataWeb(
              //         code: "ArrowUp",
              //         key: "ArrowUp",
              //         metaState: 0,
              //         keyCode: 38,
              //       ),
              //     ),
              //     {LogicalKeyboardKey.arrowUp},
              //   ),
              //   onTapCancel: () => game.onKeyEvent(
              //     const RawKeyUpEvent(
              //       data: RawKeyEventDataWeb(
              //         code: "ArrowUp",
              //         key: "ArrowUp",
              //         metaState: 0,
              //         keyCode: 38,
              //       ),
              //     ),
              //     {LogicalKeyboardKey.arrowUp},
              //   ),
              //   child: IconButton(
              //     onPressed: () {},
              //     iconSize: 250 * game.scale,
              //     icon: const Icon(
              //       Icons.speed,
              //       color: Color.fromARGB(80, 0, 0, 0),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
