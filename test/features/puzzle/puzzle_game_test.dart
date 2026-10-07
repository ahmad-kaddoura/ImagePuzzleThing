import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:image_puzzle/features/puzzle/domain/puzzle_game.dart';
import 'package:image_puzzle/core/domain/puzzle_layout.dart';

void main() {
  for (final layout in PuzzleLayout.values) {
    for (final size in [3, 5, 7, 10]) {
      test('${layout.label} $size can be completed exactly once', () {
        final game = PuzzleGame(
          dimension: size,
          layout: layout,
          random: Random(42),
        );
        expect(game.remaining.toSet().length, game.total);
        expect(
          game.remaining,
          isNot(orderedEquals(List.generate(game.total, (i) => i))),
        );
        for (var id = 0; id < game.total; id++) {
          expect(game.place(id, id), isTrue);
          expect(game.place(id, id), isFalse);
        }
        expect(game.isComplete, isTrue);
        expect(game.moves, game.total);
        expect(game.remaining, isEmpty);
      });
    }
    test('${layout.label} rejects incorrect and invalid placements', () {
      final game = PuzzleGame(dimension: 3, layout: layout);
      expect(game.place(0, 1), isFalse);
      expect(game.completed, 0);
      expect(game.moves, 1);
      expect(game.place(-1, 0), isFalse);
      expect(game.place(game.total, 0), isFalse);
      expect(game.place(0, game.total), isFalse);
      expect(game.moves, 1);
      expect(game.place(0, 0), isTrue);
      expect(game.completed, 1);
      expect(game.remaining, isNot(contains(0)));
    });
  }
  test('invalid dimensions are rejected', () {
    expect(() => PuzzleGame(dimension: 1), throwsArgumentError);
    expect(() => PuzzleGame(dimension: 11), throwsArgumentError);
  });
}
