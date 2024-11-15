import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ncu_biking/main.dart';

class Joystick extends StatelessWidget {
  const Joystick({
    super.key,
    required this.game,
  });

  final NcuBikingGame game;

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
                    const KeyDownEvent(
                      physicalKey: PhysicalKeyboardKey.arrowLeft,
                      logicalKey: LogicalKeyboardKey.arrowLeft,
                      timeStamp: Durations.short1,
                    ),
                    {LogicalKeyboardKey.arrowLeft},
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chevron_left,
                        size: 150 * game.scale,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      Text(
                        "Left / A",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontSize: 30 * game.scale,
                            ),
                      ),
                    ],
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
                    const KeyDownEvent(
                      physicalKey: PhysicalKeyboardKey.arrowRight,
                      logicalKey: LogicalKeyboardKey.arrowRight,
                      timeStamp: Durations.short1,
                    ),
                    {LogicalKeyboardKey.arrowRight},
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chevron_right,
                        size: 150 * game.scale,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      Text(
                        "Right / D",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontSize: 30 * game.scale,
                            ),
                      ),
                    ],
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
                    const KeyDownEvent(
                      physicalKey: PhysicalKeyboardKey.arrowUp,
                      logicalKey: LogicalKeyboardKey.arrowUp,
                      timeStamp: Durations.short1,
                    ),
                    {LogicalKeyboardKey.arrowUp},
                  ),
                  onTapUp: (detail) => game.onKeyEvent(
                    const KeyUpEvent(
                      physicalKey: PhysicalKeyboardKey.arrowUp,
                      logicalKey: LogicalKeyboardKey.arrowUp,
                      timeStamp: Durations.short1,
                    ),
                    {LogicalKeyboardKey.arrowUp},
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.speed,
                        size: 150 * game.scale,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      Text(
                        "Up / W",
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontSize: 30 * game.scale,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
