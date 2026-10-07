import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/puzzle_layout.dart';
import '../controllers/puzzle_controller.dart';
import 'layout_option.dart';

class LayoutSelector extends StatelessWidget {
  const LayoutSelector({super.key, required this.controller});

  final PuzzleController controller;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          const Text(
            'CHOOSE YOUR FLOW',
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1.7,
              fontWeight: FontWeight.w700,
              color: Color(0xFF74837B),
            ),
          ),
          const Spacer(),
          TextButton.icon(
            onPressed: () {
              final options = PuzzleLayout.values
                  .where((layout) => layout != controller.game.layout)
                  .toList();
              controller.restart(
                layout: options[Random().nextInt(options.length)],
              );
            },
            icon: const Icon(Icons.shuffle_rounded, size: 16),
            label: const Text('Surprise me'),
          ),
        ],
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          for (final layout in PuzzleLayout.values)
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: layout == PuzzleLayout.values.last ? 0 : 10,
                ),
                child: LayoutOption(
                  layout: layout,
                  selected: controller.game.layout == layout,
                  onTap: () => controller.restart(layout: layout),
                ),
              ),
            ),
        ],
      ),
    ],
  );
}
