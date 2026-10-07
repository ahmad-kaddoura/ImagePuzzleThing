import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:image_puzzle/core/domain/puzzle_layout.dart';

import '../controllers/puzzle_controller.dart';
import '../controllers/puzzle_feedback.dart';
import 'scenic_puzzle_scene.dart';

class PuzzleWorkspace extends StatefulWidget {
  const PuzzleWorkspace({
    super.key,
    required this.image,
    required this.title,
    this.initialLayout = PuzzleLayout.jigsaw,
    this.initialDimension = 3,
    this.onSettings,
    this.snapToPosition = true,
    this.showPiecePreview = true,
    this.highlightMatchingAreas = true,
    this.soundEnabled = true,
    this.hapticsEnabled = true,
  });

  final ui.Image image;
  final String title;
  final PuzzleLayout initialLayout;
  final int initialDimension;
  final Future<void> Function()? onSettings;
  final bool snapToPosition;
  final bool showPiecePreview;
  final bool highlightMatchingAreas;
  final bool soundEnabled;
  final bool hapticsEnabled;

  @override
  State<PuzzleWorkspace> createState() => _PuzzleWorkspaceState();
}

class _PuzzleWorkspaceState extends State<PuzzleWorkspace> {
  late final _controller = PuzzleController(
    dimension: widget.initialDimension,
    layout: widget.initialLayout,
    snapToPosition: widget.snapToPosition,
    showPiecePreview: widget.showPiecePreview,
    highlightMatchingAreas: widget.highlightMatchingAreas,
  );
  final _feedback = PuzzleFeedback();

  @override
  void initState() {
    super.initState();
    _controller.select(_controller.game.order.first);
    _feedback.soundEnabled = widget.soundEnabled;
    _feedback.hapticsEnabled = widget.hapticsEnabled;
    _feedback.prepare();
  }

  @override
  void didUpdateWidget(PuzzleWorkspace oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.snapToPosition = widget.snapToPosition;
    _controller.showPiecePreview = widget.showPiecePreview;
    _controller.highlightMatchingAreas = widget.highlightMatchingAreas;
    _feedback.soundEnabled = widget.soundEnabled;
    _feedback.hapticsEnabled = widget.hapticsEnabled;
  }

  Future<void> _settings() async {
    _controller.setPaused(true);
    try {
      await widget.onSettings?.call();
    } finally {
      if (mounted) _controller.setPaused(false);
    }
  }

  void _place(int piece, int slot) {
    if (_controller.preview || _controller.game.isPlaced(slot)) return;
    if (_controller.place(piece, slot)) {
      _feedback.placed(complete: _controller.game.isComplete);
    } else {
      _feedback.rejected();
    }
  }

  void _drop(int piece, int slot) {
    if (_controller.snapToPosition) {
      _place(piece, slot);
      return;
    }
    _controller.select(piece, toggle: false);
    _feedback.rejected();
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
    builder: (context, child) => ScenicPuzzleScene(
      image: widget.image,
      title: widget.title,
      controller: _controller,
      onSettings: _settings,
      onPlace: _place,
      onDrop: _drop,
    ),
  );
}
