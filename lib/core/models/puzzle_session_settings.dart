import 'package:flutter/material.dart';

import '../domain/puzzle_difficulty.dart';
import '../domain/puzzle_layout.dart';

export '../domain/puzzle_difficulty.dart';

enum PuzzleImageSource { sample, gallery, camera }

@immutable
class PuzzleSessionSettings {
  const PuzzleSessionSettings({
    required this.image,
    required this.title,
    this.imageSource = PuzzleImageSource.sample,
    this.difficulty = PuzzleDifficulty.medium,
    this.layout = PuzzleLayout.jigsaw,
    this.showPiecePreview = true,
    this.snapToPosition = true,
    this.highlightMatchingAreas = true,
    this.soundEnabled = true,
    this.hapticsEnabled = true,
  });

  final ImageProvider image;
  final String title;
  final PuzzleImageSource imageSource;
  final PuzzleDifficulty difficulty;
  final PuzzleLayout layout;
  final bool showPiecePreview;
  final bool snapToPosition;
  final bool highlightMatchingAreas;
  final bool soundEnabled;
  final bool hapticsEnabled;

  PuzzleSessionSettings copyWith({
    ImageProvider? image,
    String? title,
    PuzzleImageSource? imageSource,
    PuzzleDifficulty? difficulty,
    PuzzleLayout? layout,
    bool? showPiecePreview,
    bool? snapToPosition,
    bool? highlightMatchingAreas,
    bool? soundEnabled,
    bool? hapticsEnabled,
  }) => PuzzleSessionSettings(
    image: image ?? this.image,
    title: title ?? this.title,
    imageSource: imageSource ?? this.imageSource,
    difficulty: difficulty ?? this.difficulty,
    layout: layout ?? this.layout,
    showPiecePreview: showPiecePreview ?? this.showPiecePreview,
    snapToPosition: snapToPosition ?? this.snapToPosition,
    highlightMatchingAreas:
        highlightMatchingAreas ?? this.highlightMatchingAreas,
    soundEnabled: soundEnabled ?? this.soundEnabled,
    hapticsEnabled: hapticsEnabled ?? this.hapticsEnabled,
  );
}
