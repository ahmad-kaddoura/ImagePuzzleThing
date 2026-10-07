import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../domain/puzzle_game.dart';

import 'package:image_puzzle/core/domain/puzzle_layout.dart';

class PuzzleController extends ChangeNotifier {
  PuzzleController({
    int dimension = 3,
    PuzzleLayout layout = PuzzleLayout.jigsaw,
    this.snapToPosition = true,
    this.showPiecePreview = true,
    this.highlightMatchingAreas = true,
  }) : game = PuzzleGame(dimension: dimension, layout: layout) {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_paused && !game.isComplete && game.moves > 0) {
        seconds++;
        notifyListeners();
      }
    });
  }

  late final Timer _timer;
  PuzzleGame game;
  bool snapToPosition;
  bool showPiecePreview;
  bool highlightMatchingAreas;
  int? selected;
  int? rejectedSlot;
  Timer? _rejectionTimer;
  int seconds = 0;
  bool preview = false;
  bool _paused = false;

  void setPaused(bool value) => _paused = value;

  String get elapsed =>
      '${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}';

  void select(int piece, {bool toggle = true}) {
    selected = toggle && selected == piece ? null : piece;
    notifyListeners();
  }

  bool place(int piece, int slot) {
    final accepted = game.place(piece, slot);
    _rejectionTimer?.cancel();
    rejectedSlot = accepted ? null : slot;
    if (accepted) {
      selected = null;
    } else {
      _rejectionTimer = Timer(const Duration(milliseconds: 650), () {
        rejectedSlot = null;
        notifyListeners();
      });
    }
    notifyListeners();
    return accepted;
  }

  void togglePreview() {
    preview = !preview;
    notifyListeners();
  }

  void restart({int? dimension, PuzzleLayout? layout}) {
    game = PuzzleGame(
      dimension: dimension ?? game.dimension,
      layout: layout ?? game.layout,
    );
    selected = null;
    rejectedSlot = null;
    _rejectionTimer?.cancel();
    seconds = 0;
    preview = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer.cancel();
    _rejectionTimer?.cancel();
    super.dispose();
  }
}
