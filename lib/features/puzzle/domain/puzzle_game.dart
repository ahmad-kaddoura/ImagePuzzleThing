import 'dart:math';

import 'puzzle_layout.dart';

class PuzzleGame {
  PuzzleGame({
    required this.dimension,
    this.layout = PuzzleLayout.jigsaw,
    Random? random,
  }) {
    if (dimension < 2 || dimension > 6) {
      throw ArgumentError.value(
        dimension,
        'dimension',
        'Must be between 2 and 6',
      );
    }
    order = List.unmodifiable(
      List.generate(total, (index) => index)..shuffle(random ?? Random()),
    );
  }

  final int dimension;
  final PuzzleLayout layout;
  late final List<int> order;
  final Set<int> _placed = {};
  int _moves = 0;

  int get total => layout.pieceCount(dimension);
  int get moves => _moves;
  int get completed => _placed.length;
  bool get isComplete => completed == total;
  List<int> get remaining =>
      order.where((id) => !_placed.contains(id)).toList(growable: false);
  bool isPlaced(int id) => _placed.contains(id);

  bool place(int piece, int slot) {
    if (piece < 0 ||
        piece >= total ||
        slot < 0 ||
        slot >= total ||
        isPlaced(piece)) {
      return false;
    }
    _moves++;
    if (piece != slot) return false;
    return _placed.add(piece);
  }
}
