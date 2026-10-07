import 'package:flutter/material.dart';

import '../controllers/puzzle_controller.dart';
import 'puzzle_counter_pill.dart';

class PuzzleCounters extends StatelessWidget {
  const PuzzleCounters({super.key, required this.controller});

  final PuzzleController controller;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        child: PuzzleCounterPill(
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 9),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.extension_rounded,
                  color: Color(0xFF246B61),
                  size: 24,
                ),
                const SizedBox(width: 12),
                Semantics(
                  liveRegion: true,
                  label:
                      '${controller.game.completed} of ${controller.game.total} pieces placed',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${controller.game.completed} / ${controller.game.total}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF122D32),
                        ),
                      ),
                      const Text(
                        'pieces',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF78888C),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(width: 16),
      Flexible(
        child: PuzzleCounterPill(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.timer_outlined,
                  color: Color(0xFF246B61),
                  size: 23,
                ),
                const SizedBox(width: 9),
                Text(
                  controller.elapsed,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF122D32),
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
