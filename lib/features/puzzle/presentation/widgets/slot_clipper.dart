import 'package:flutter/material.dart';

import '../../domain/puzzle_layout.dart';
import 'piece_path.dart';

class SlotClipper extends CustomClipper<Path> {
  const SlotClipper({
    required this.id,
    required this.dimension,
    required this.layout,
  });

  final int id;
  final int dimension;
  final PuzzleLayout layout;

  @override
  Path getClip(Size size) =>
      PiecePath.create(id, dimension, size.width, layout).shift(
        Offset(
          -size.width * PiecePath.padding,
          -size.width * PiecePath.padding,
        ),
      );

  @override
  bool shouldReclip(SlotClipper old) =>
      id != old.id || dimension != old.dimension || layout != old.layout;
}
