import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class PuzzleFeedback {
  AudioPool? _snap;
  AudioPool? _complete;
  bool _disposed = false;
  bool soundEnabled = true;
  bool hapticsEnabled = true;

  Future<void> prepare() async {
    try {
      for (final name in ['snap', 'complete']) {
        final pool = await AudioPool.createFromAsset(
          path: 'audio/$name.wav',
          maxPlayers: 3,
        );
        if (_disposed) {
          await pool.dispose();
          continue;
        }
        if (name == 'snap') {
          _snap = pool;
        } else {
          _complete = pool;
        }
      }
    } on Exception {
      return;
    }
  }

  Future<void> placed({required bool complete}) async {
    if (_disposed) return;
    if (hapticsEnabled) {
      unawaited(
        complete ? HapticFeedback.mediumImpact() : HapticFeedback.lightImpact(),
      );
    }
    if (!soundEnabled) return;
    try {
      await (complete ? _complete : _snap)?.start(volume: .55);
    } on Exception {
      return;
    }
  }

  void rejected() {
    if (!_disposed && hapticsEnabled) {
      unawaited(HapticFeedback.selectionClick());
    }
  }

  void dispose() {
    _disposed = true;
    _snap?.dispose();
    _complete?.dispose();
  }
}
