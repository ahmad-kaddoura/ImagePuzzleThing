import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/puzzle_layout.dart';
import '../controllers/puzzle_controller.dart';

class CompactLayoutSelector extends StatelessWidget {
  const CompactLayoutSelector({super.key, required this.controller});

  final PuzzleController controller;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: SegmentedButton<PuzzleLayout>(
          showSelectedIcon: false,
          segments: const [
            ButtonSegment(value: PuzzleLayout.jigsaw, label: Text('Jigsaw')),
            ButtonSegment(value: PuzzleLayout.mosaic, label: Text('Mosaic')),
            ButtonSegment(value: PuzzleLayout.triangles, label: Text('Prism')),
          ],
          selected: {controller.game.layout},
          onSelectionChanged: (values) =>
              controller.restart(layout: values.first),
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
          ),
        ),
      ),
      const SizedBox(width: 8),
      IconButton.filledTonal(
        tooltip: 'Random layout',
        onPressed: () {
          final options = PuzzleLayout.values
              .where((layout) => layout != controller.game.layout)
              .toList();
          controller.restart(layout: options[Random().nextInt(options.length)]);
        },
        icon: const Icon(Icons.shuffle_rounded, size: 20),
      ),
    ],
  );
}
