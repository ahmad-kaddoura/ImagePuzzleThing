import 'puzzle_layout.dart';

enum PuzzleDifficulty {
  easy('Easy', 3),
  medium('Medium', 5),
  hard('Hard', 7),
  expert('Expert', 10);

  const PuzzleDifficulty(this.label, this.dimension);

  final String label;
  final int dimension;
  int get pieceCount => dimension * dimension;
  int pieceCountFor(PuzzleLayout layout) => layout.pieceCount(dimension);
}
