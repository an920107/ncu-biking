import 'package:flutter/material.dart';
import 'package:ncu_biking/main.dart';

class StartGame extends StatefulWidget {
  const StartGame({
    super.key,
    required this.game,
  });

  final Main game;

  @override
  State<StartGame> createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
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
              widget.game.overlays
                  .removeAll(widget.game.overlays.activeOverlays.toList());
              widget.game.router.pushReplacementNamed("playing");
            }
          : null,
      child: Container(
        width: widget.game.size.x,
        height: widget.game.size.y,
        color: const Color.fromARGB(0, 0, 0, 0),
      ),
    );
  }
}
