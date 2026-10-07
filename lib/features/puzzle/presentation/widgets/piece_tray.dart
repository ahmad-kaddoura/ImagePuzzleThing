import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../controllers/puzzle_controller.dart';
import 'piece_tile.dart';

class PieceTray extends StatelessWidget {
  const PieceTray({super.key, required this.image, required this.controller});

  final ui.Image image;
  final PuzzleController controller;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: const Color(0xFFE7EAE1)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Your pieces',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const Spacer(),
            Text(
              '${controller.game.remaining.length} left',
              style: const TextStyle(color: Color(0xFF74837B)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          controller.game.isComplete
              ? 'A little patience. A beautiful picture.'
              : 'Find a familiar detail. Make it fit.',
          style: const TextStyle(color: Color(0xFF74837B)),
        ),
        const SizedBox(height: 20),
        if (controller.game.isComplete)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF24786C),
                size: 64,
              ),
            ),
          )
        else
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth < 320 ? 3 : 4;
              final cell =
                  ((constraints.maxWidth - (columns - 1) * 10) / columns - 12) /
                  1.44;
              return Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final id in controller.game.remaining)
                    PieceTile(
                      image: image,
                      id: id,
                      dimension: controller.game.dimension,
                      layout: controller.game.layout,
                      selected: controller.selected == id,
                      onTap: () => controller.select(id),
                      cell: cell,
                    ),
                ],
              );
            },
          ),
        const SizedBox(height: 22),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.touch_app_outlined, size: 18, color: Color(0xFF74837B)),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Drag a piece onto the board, or tap a piece and then a space.',
                style: TextStyle(
                  fontSize: 12,
                  height: 1.6,
                  color: Color(0xFF74837B),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
