import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../domain/puzzle_layout.dart';

import 'puzzle_piece.dart';

class PieceTile extends StatelessWidget {
  const PieceTile({
    super.key,
    required this.image,
    required this.id,
    required this.dimension,
    required this.layout,
    required this.selected,
    required this.onTap,
    required this.cell,
    this.feedbackCell,
  });

  final ui.Image image;
  final int id;
  final int dimension;
  final PuzzleLayout layout;
  final bool selected;
  final VoidCallback onTap;
  final double cell;
  final double? feedbackCell;

  @override
  Widget build(BuildContext context) {
    final piece = PuzzlePiece(
      image: image,
      id: id,
      dimension: dimension,
      layout: layout,
      cell: cell,
    );
    return Semantics(
      button: true,
      selected: selected,
      label: 'Puzzle piece ${id + 1}. Select, then tap a board slot.',
      child: Draggable<int>(
        data: id,
        affinity: Axis.vertical,
        dragAnchorStrategy: (draggable, context, position) =>
            Offset((feedbackCell ?? cell) * .72, (feedbackCell ?? cell) * .72),
        maxSimultaneousDrags: 1,
        feedback: Material(
          color: Colors.transparent,
          child: PuzzlePiece(
            image: image,
            id: id,
            dimension: dimension,
            layout: layout,
            cell: feedbackCell ?? cell,
          ),
        ),
        childWhenDragging: Opacity(opacity: .2, child: piece),
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: Duration(
              milliseconds: MediaQuery.disableAnimationsOf(context) ? 0 : 180,
            ),
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFFD7E9DF)
                  : const Color(0xFFF3F2ED),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: selected ? const Color(0xFF24786C) : Colors.transparent,
                width: 2,
              ),
            ),
            padding: const EdgeInsets.all(4),
            child: piece,
          ),
        ),
      ),
    );
  }
}
