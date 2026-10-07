import 'package:flutter_test/flutter_test.dart';
import 'package:image_puzzle/features/puzzle/domain/puzzle_layout.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/piece_path.dart';

void main() {
  for (final layout in PuzzleLayout.values) {
    test('${layout.label} pieces cover the image without gaps or overlaps', () {
      const dimension = 3;
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
      for (var x = .37; x < 300; x += 3.13) {
        for (var y = .71; y < 300; y += 3.17) {
          expect(
            paths.where((path) => path.contains(Offset(x, y))).length,
            1,
            reason: 'Coverage at $x, $y',
          );
        }
      }
      expect(paths.any((path) => path.contains(const Offset(-1, 50))), isFalse);
      expect(
        paths.any((path) => path.contains(const Offset(301, 50))),
        isFalse,
      );
    });
  }
}
