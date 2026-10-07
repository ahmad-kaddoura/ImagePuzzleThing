import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../controllers/puzzle_controller.dart';
import 'piece_tile.dart';

class PieceStrip extends StatelessWidget {
  const PieceStrip({
    super.key,
    required this.image,
    required this.controller,
    required this.feedbackCell,
  });

  final ui.Image image;
  final PuzzleController controller;
  final double feedbackCell;

  @override
  Widget build(BuildContext context) {
    final remaining = controller.game.remaining;
    final selected = controller.selected;
    final pieces = selected != null && remaining.contains(selected)
        ? [selected, ...remaining.where((id) => id != selected)]
        : remaining;
    return SizedBox(
      height: 80,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        itemCount: pieces.length,
        separatorBuilder: (context, index) => const SizedBox(width: 7),
        itemBuilder: (context, index) => PieceTile(
          key: ValueKey('strip-piece-${pieces[index]}'),
          image: image,
          id: pieces[index],
          dimension: controller.game.dimension,
          layout: controller.game.layout,
          selected: selected == pieces[index],
          onTap: () => controller.select(pieces[index]),
          cell: 46,
          feedbackCell: feedbackCell,
        ),
      ),
    );
  }
}
