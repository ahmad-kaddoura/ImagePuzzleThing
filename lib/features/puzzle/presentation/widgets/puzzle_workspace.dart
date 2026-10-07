import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../domain/puzzle_layout.dart';
import '../controllers/puzzle_controller.dart';
import '../controllers/puzzle_feedback.dart';
import 'compact_puzzle_workspace.dart';
import 'wide_puzzle_workspace.dart';

class PuzzleWorkspace extends StatefulWidget {
  const PuzzleWorkspace({
    super.key,
    required this.image,
    required this.title,
    this.initialLayout = PuzzleLayout.jigsaw,
    this.initialDimension = 3,
  });

  final ui.Image image;
  final String title;
  final PuzzleLayout initialLayout;
  final int initialDimension;

  @override
  State<PuzzleWorkspace> createState() => _PuzzleWorkspaceState();
}

class _PuzzleWorkspaceState extends State<PuzzleWorkspace> {
  late final _controller = PuzzleController(
    dimension: widget.initialDimension,
    layout: widget.initialLayout,
  );
  final _feedback = PuzzleFeedback();

  @override
  void initState() {
    super.initState();
    _feedback.prepare();
  }

  void _place(int piece, int slot) {
    if (_controller.preview || _controller.game.isPlaced(slot)) return;
    if (_controller.place(piece, slot)) {
      _feedback.placed(complete: _controller.game.isComplete);
    } else {
      _feedback.rejected();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _feedback.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: _controller,
    builder: (context, child) => LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600 && constraints.hasBoundedHeight) {
          return CompactPuzzleWorkspace(
            image: widget.image,
            title: widget.title,
            controller: _controller,
            feedback: _feedback,
            onFeedbackChanged: () => setState(() {}),
            onPlace: _place,
          );
        }
        return WidePuzzleWorkspace(
          image: widget.image,
          title: widget.title,
          controller: _controller,
          feedback: _feedback,
          onFeedbackChanged: () => setState(() {}),
          onPlace: _place,
        );
      },
    ),
  );
}
