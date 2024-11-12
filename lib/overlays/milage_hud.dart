import 'package:flutter/material.dart';
import 'package:ncu_biking/main.dart';
import 'package:provider/provider.dart';

class MilageHud extends StatelessWidget {
  const MilageHud({
    super.key,
    required this.game,
  });

  final NcuBikingGame game;

  @override
  Widget build(BuildContext context) {
    return Consumer<GameResizeNotifier>(
      builder: (context, value, child) => Padding(
        padding: EdgeInsets.only(
          top: 20 * game.scale,
          left: game.size.x / 2 - 450 * game.scale,
        ),
        child: Container(
          padding: const EdgeInsets.only(
                top: 5,
                right: 30,
                bottom: 5,
                left: 30,
              ) *
              game.scale,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(187, 255, 255, 255),
          ),
          child: Consumer<MilageChangeNotifier>(
            builder: (context, value, child) => Text(
              "milage: ${(game.milage / game.milageCoefficient).toStringAsFixed(2)} km",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 80 * game.scale,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
