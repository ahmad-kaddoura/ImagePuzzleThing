import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/puzzle_session_settings.dart';

final puzzleSessionProvider =
    NotifierProvider<PuzzleSessionNotifier, PuzzleSessionSettings>(
      PuzzleSessionNotifier.new,
    );

class PuzzleSessionNotifier extends Notifier<PuzzleSessionSettings> {
  @override
  PuzzleSessionSettings build() => const PuzzleSessionSettings(
    image: AssetImage('assets/images/lakeside_reference.png'),
    title: 'Lakeside daydream',
  );

  void update(PuzzleSessionSettings settings) => state = settings;
}
