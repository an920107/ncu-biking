import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ncu_biking/main.dart';

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({
    super.key,
    required this.game,
  });

  final NcuBikingGame game;

  @override
  Widget build(BuildContext context) {
    const double squareSizeLimit = 400;
    final double squareSize = min(game.size.x, game.size.y) * 0.8;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: squareSize,
            height: squareSize,
            constraints: const BoxConstraints(maxHeight: squareSizeLimit, maxWidth: squareSizeLimit),
            child: Image.memory(game.faviconImage),
          ),
          Text(
            "Loading...",
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontSize: min(squareSize, squareSizeLimit) * 0.15,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                ),
          )
        ],
      ),
    );
  }
}
