import 'package:flutter/material.dart';
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
              Icon(
                Icons.arrow_circle_left_outlined,
                size: 200 * game.scale,
                color: const Color.fromARGB(80, 0, 0, 0),
              ),
              SizedBox(width: 100 * game.scale),
              Icon(
                Icons.arrow_circle_up,
                size: 200 * game.scale,
                color: const Color.fromARGB(80, 0, 0, 0),
              ),
              SizedBox(width: 100 * game.scale),
              Icon(
                Icons.arrow_circle_right_outlined,
                size: 200 * game.scale,
                color: const Color.fromARGB(80, 0, 0, 0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
