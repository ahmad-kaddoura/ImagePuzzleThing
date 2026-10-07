import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../controllers/puzzle_controller.dart';
import 'piece_grid_tile.dart';

class PuzzlePieceGrid extends StatelessWidget {
  const PuzzlePieceGrid({
    super.key,
    required this.image,
    required this.controller,
    required this.feedbackCell,
    required this.onSelect,
    required this.onDragStarted,
  });

  final ui.Image image;
  final PuzzleController controller;
  final double feedbackCell;
  final ValueChanged<int> onSelect;
  final VoidCallback onDragStarted;

  @override
  Widget build(BuildContext context) => SliverPadding(
    padding: const EdgeInsets.symmetric(horizontal: 18),
    sliver: SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 96,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final id = controller.game.order[index];
        return PieceGridTile(
          key: ValueKey('grid-piece-$id'),
          image: image,
          id: id,
          controller: controller,
          feedbackCell: feedbackCell,
          onSelect: () => onSelect(id),
          onDragStarted: onDragStarted,
        );
      }, childCount: controller.game.total),
    ),
  );
}
