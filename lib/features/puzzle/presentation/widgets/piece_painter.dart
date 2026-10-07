import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:image_puzzle/core/domain/puzzle_layout.dart';

import 'piece_path.dart';

class PiecePainter extends CustomPainter {
  PiecePainter({
    required this.image,
    required this.id,
    required this.dimension,
    required this.layout,
    required this.cell,
    required this.ghost,
    required this.revealGhost,
  });

  final ui.Image image;
  final int id;
  final int dimension;
  final PuzzleLayout layout;
  final double cell;
  final bool ghost;
  final bool revealGhost;

  @override
  void paint(Canvas canvas, Size size) {
    final path = PiecePath.create(id, dimension, cell, layout);
    if (ghost && !revealGhost) {
      canvas.drawPath(path, Paint()..color = const Color(0xFFE7E8E2));
    } else {
      canvas.drawShadow(path, const Color(0x5534493D), 3, false);
      canvas.save();
      canvas.clipPath(path);
      if (ghost) {
        canvas.saveLayer(
          path.getBounds(),
          Paint()..color = const Color(0x70FFFFFF),
        );
      }
      final side = image.width < image.height
          ? image.width.toDouble()
          : image.height.toDouble();
      final source = Rect.fromLTWH(
        (image.width - side) / 2,
        (image.height - side) / 2,
        side,
        side,
      );
      final destination = Rect.fromLTWH(
        cell * PiecePath.padding - (layout.cellIndex(id) % dimension) * cell,
        cell * PiecePath.padding - (layout.cellIndex(id) ~/ dimension) * cell,
        cell * dimension,
        cell * dimension,
      );
      canvas.drawImageRect(
        image,
        source,
        destination,
        Paint()..filterQuality = FilterQuality.medium,
      );
      canvas.restore();
      if (ghost) canvas.restore();
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = ghost ? const Color(0xFFC4CCC3) : const Color(0xAAFFFFFF)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(PiecePainter old) =>
      image != old.image ||
      id != old.id ||
      layout != old.layout ||
      dimension != old.dimension ||
      cell != old.cell ||
      ghost != old.ghost ||
      revealGhost != old.revealGhost;
}
