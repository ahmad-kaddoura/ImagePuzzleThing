import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../domain/puzzle_layout.dart';

import 'piece_path.dart';
import 'piece_painter.dart';

class PuzzlePiece extends StatelessWidget {
  const PuzzlePiece({
    super.key,
    required this.image,
    required this.id,
    required this.dimension,
    required this.layout,
    required this.cell,
    this.ghost = false,
  });

  final ui.Image image;
  final int id;
  final int dimension;
  final PuzzleLayout layout;
  final double cell;
  final bool ghost;

  @override
  Widget build(BuildContext context) => CustomPaint(
    size: Size.square(cell * (1 + PiecePath.padding * 2)),
    painter: PiecePainter(
      image: image,
      id: id,
      dimension: dimension,
      layout: layout,
      cell: cell,
      ghost: ghost,
    ),
  );
}
