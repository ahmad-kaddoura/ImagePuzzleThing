import 'package:flutter_test/flutter_test.dart';
import 'package:image_puzzle/core/domain/puzzle_layout.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/piece_path.dart';

void main() {
  for (final layout in PuzzleLayout.values) {
    for (final dimension in [3, 5, 7, 10]) {
      test(
        '${layout.label} $dimension pieces cover the image without gaps or overlaps',
        () {
          const cell = 100.0;
          final paths = List.generate(layout.pieceCount(dimension), (id) {
            final index = layout.cellIndex(id);
            return PiecePath.create(id, dimension, cell, layout).shift(
              Offset(
                (index % dimension) * cell - cell * PiecePath.padding,
                (index ~/ dimension) * cell - cell * PiecePath.padding,
              ),
            );
          });
          for (
            var x = .37;
            x < cell * dimension;
            x += cell * dimension / 97.13
          ) {
            for (
              var y = .71;
              y < cell * dimension;
              y += cell * dimension / 97.17
            ) {
              expect(
                paths.where((path) => path.contains(Offset(x, y))).length,
                1,
                reason: 'Coverage at $x, $y',
              );
            }
          }
          expect(
            paths.any((path) => path.contains(const Offset(-1, 50))),
            isFalse,
          );
          expect(
            paths.any(
              (path) => path.contains(Offset(cell * dimension + 1, 50)),
            ),
            isFalse,
          );
        },
      );
    }
  }
}
