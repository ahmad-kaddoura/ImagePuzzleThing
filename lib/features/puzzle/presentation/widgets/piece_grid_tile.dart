import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../controllers/puzzle_controller.dart';
import 'piece_tile.dart';

class PieceGridTile extends StatelessWidget {
  const PieceGridTile({
    super.key,
    required this.image,
    required this.id,
    required this.controller,
    required this.feedbackCell,
    required this.onSelect,
    required this.onDragStarted,
  });

  final ui.Image image;
  final int id;
  final PuzzleController controller;
  final double feedbackCell;
  final VoidCallback onSelect;
  final VoidCallback onDragStarted;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => PieceTile(
      image: image,
      id: id,
      dimension: controller.game.dimension,
      layout: controller.game.layout,
      selected: controller.selected == id,
      used: controller.game.isPlaced(id),
      onTap: onSelect,
      cell: (min(constraints.maxWidth, constraints.maxHeight) - 12) / 1.44,
      feedbackCell: feedbackCell,
      longPressToDrag: true,
      onDragStarted: onDragStarted,
    ),
  );
}
