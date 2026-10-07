import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../domain/puzzle_layout.dart';
import 'piece_tile_surface.dart';
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
    this.used = false,
    this.longPressToDrag = false,
    this.onDragStarted,
  });

  final ui.Image image;
  final int id;
  final int dimension;
  final PuzzleLayout layout;
  final bool selected;
  final VoidCallback onTap;
  final double cell;
  final double? feedbackCell;
  final bool used;
  final bool longPressToDrag;
  final VoidCallback? onDragStarted;

  @override
  Widget build(BuildContext context) {
    final piece = PuzzlePiece(
      image: image,
      id: id,
      dimension: dimension,
      layout: layout,
      cell: cell,
    );
    final surface = PieceTileSurface(
      selected: selected,
      used: used,
      child: piece,
    );
    final child = GestureDetector(onTap: used ? null : onTap, child: surface);
    final feedback = Material(
      color: Colors.transparent,
      child: PuzzlePiece(
        image: image,
        id: id,
        dimension: dimension,
        layout: layout,
        cell: feedbackCell ?? cell,
      ),
    );
    final anchor = (feedbackCell ?? cell) * .72;
    final draggable = longPressToDrag
        ? LongPressDraggable<int>(
            data: id,
            delay: const Duration(milliseconds: 220),
            maxSimultaneousDrags: 1,
            onDragStarted: onDragStarted,
            dragAnchorStrategy: (draggable, context, position) =>
                Offset(anchor, anchor),
            feedback: feedback,
            childWhenDragging: Opacity(opacity: .2, child: surface),
            child: child,
          )
        : Draggable<int>(
            data: id,
            affinity: Axis.vertical,
            maxSimultaneousDrags: 1,
            onDragStarted: onDragStarted,
            dragAnchorStrategy: (draggable, context, position) =>
                Offset(anchor, anchor),
            feedback: feedback,
            childWhenDragging: Opacity(opacity: .2, child: surface),
            child: child,
          );
    return Semantics(
      button: !used,
      enabled: !used,
      selected: selected && !used,
      label: used
          ? 'Puzzle piece ${id + 1}, placed'
          : 'Puzzle piece ${id + 1}. Select, then tap a board slot.',
      child: used ? surface : draggable,
    );
  }
}
