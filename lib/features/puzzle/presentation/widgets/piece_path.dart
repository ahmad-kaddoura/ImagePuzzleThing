import 'package:flutter/material.dart';

import '../../domain/puzzle_layout.dart';

abstract final class PiecePath {
  static const padding = .22;

  static Path create(int id, int dimension, double cell, PuzzleLayout layout) {
    final index = layout.cellIndex(id);
    final row = index ~/ dimension;
    final col = index % dimension;
    final p = cell * padding;
    final path = Path()..moveTo(p, p);
    if (layout == PuzzleLayout.mosaic) {
      return Path()..addRect(Rect.fromLTWH(p, p, cell, cell));
    }
    if (layout == PuzzleLayout.triangles) {
      if (id.isEven) {
        path
          ..lineTo(p + cell, p)
          ..lineTo(p, p + cell);
      } else {
        path
          ..moveTo(p + cell, p)
          ..lineTo(p + cell, p + cell)
          ..lineTo(p, p + cell);
      }
      return path..close();
    }
    final parity = (row + col).isEven ? 1.0 : -1.0;
    edge(
      path,
      Offset(p, p),
      const Offset(1, 0),
      const Offset(0, -1),
      cell,
      row == 0 ? 0 : parity,
    );
    edge(
      path,
      Offset(p + cell, p),
      const Offset(0, 1),
      const Offset(1, 0),
      cell,
      col == dimension - 1 ? 0 : parity,
    );
    edge(
      path,
      Offset(p + cell, p + cell),
      const Offset(-1, 0),
      const Offset(0, 1),
      cell,
      row == dimension - 1 ? 0 : parity,
    );
    edge(
      path,
      Offset(p, p + cell),
      const Offset(0, -1),
      const Offset(-1, 0),
      cell,
      col == 0 ? 0 : parity,
    );
    return path..close();
  }

  static void edge(
    Path path,
    Offset start,
    Offset tangent,
    Offset normal,
    double size,
    double sign,
  ) {
    Offset point(double along, double out) =>
        start + tangent * (along * size) + normal * (out * size * sign);
    void curve(double a, double b, double c, double d, double e, double f) {
      final p1 = point(a, b);
      final p2 = point(c, d);
      final p3 = point(e, f);
      path.cubicTo(p1.dx, p1.dy, p2.dx, p2.dy, p3.dx, p3.dy);
    }

    final neck = point(.38, 0);
    path.lineTo(neck.dx, neck.dy);
    if (sign != 0) {
      curve(.44, 0, .35, .17, .5, .17);
      curve(.65, .17, .56, 0, .62, 0);
    }
    final end = point(1, 0);
    path.lineTo(end.dx, end.dy);
  }
}
