import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../controllers/puzzle_controller.dart';
import '../controllers/puzzle_feedback.dart';
import 'compact_layout_selector.dart';
import 'compact_piece_tray.dart';
import 'compact_puzzle_toolbar.dart';
import 'puzzle_board.dart';
import 'puzzle_progress.dart';

class CompactPuzzleWorkspace extends StatelessWidget {
  const CompactPuzzleWorkspace({
    super.key,
    required this.image,
    required this.title,
    required this.controller,
    required this.feedback,
    required this.onFeedbackChanged,
    required this.onPlace,
  });

  final ui.Image image;
  final String title;
  final PuzzleController controller;
  final PuzzleFeedback feedback;
  final VoidCallback onFeedbackChanged;
  final void Function(int, int) onPlace;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final boardSide = max(
        80.0,
        min(constraints.maxWidth - 32, constraints.maxHeight - 414),
      );
      return Column(
        children: [
          CompactLayoutSelector(controller: controller),
          const SizedBox(height: 4),
          CompactPuzzleToolbar(
            controller: controller,
            feedback: feedback,
            onFeedbackChanged: onFeedbackChanged,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE6E9E1)),
              ),
              child: Column(
                children: [
                  PuzzleProgress(controller: controller, title: title),
                  const SizedBox(height: 16),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, available) {
                        final side = min(
                          available.maxWidth,
                          available.maxHeight,
                        );
                        return Center(
                          child: SizedBox.square(
                            dimension: side,
                            child: PuzzleBoard(
                              image: image,
                              controller: controller,
                              onPlace: onPlace,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.rejectedSlot != null
                        ? 'Not quite. Try another space.'
                        : controller.preview
                        ? 'Hide the preview to keep playing.'
                        : controller.game.isComplete
                        ? 'Every piece found its place.'
                        : 'One piece at a time.',
                    style: const TextStyle(
                      color: Color(0xFF74837B),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          CompactPieceTray(
            image: image,
            controller: controller,
            feedbackCell: boardSide / controller.game.dimension,
          ),
        ],
      );
    },
  );
}
