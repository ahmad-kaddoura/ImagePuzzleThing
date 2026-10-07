import 'package:flutter/material.dart';

import '../controllers/puzzle_controller.dart';

class PuzzleProgress extends StatelessWidget {
  const PuzzleProgress({
    super.key,
    required this.controller,
    required this.title,
  });

  final PuzzleController controller;
  final String title;

  @override
  Widget build(BuildContext context) {
    final game = controller.game;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                game.isComplete ? 'Beautifully done.' : title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Icon(
              Icons.timer_outlined,
              size: 16,
              color: Color(0xFF74837B),
            ),
            const SizedBox(width: 5),
            Text(
              controller.elapsed,
              style: const TextStyle(
                color: Color(0xFF74837B),
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        TweenAnimationBuilder<double>(
          tween: Tween(end: game.completed / game.total),
          duration: const Duration(milliseconds: 300),
          builder: (context, value, child) => ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 5,
              color: const Color(0xFF24786C),
              backgroundColor: const Color(0xFFE6E9E1),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              '${game.completed} of ${game.total} pieces',
              style: const TextStyle(fontSize: 12, color: Color(0xFF74837B)),
            ),
            const Spacer(),
            Text(
              '${game.moves} moves',
              style: const TextStyle(fontSize: 12, color: Color(0xFF74837B)),
            ),
          ],
        ),
      ],
    );
  }
}
