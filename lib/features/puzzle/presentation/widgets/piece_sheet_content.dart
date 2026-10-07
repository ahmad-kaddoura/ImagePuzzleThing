import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../controllers/puzzle_controller.dart';
import 'piece_sheet_header.dart';
import 'piece_sheet_hint.dart';
import 'piece_strip.dart';
import 'puzzle_piece_grid.dart';

class PieceSheetContent extends StatelessWidget {
  const PieceSheetContent({
    super.key,
    required this.image,
    required this.controller,
    required this.scrollController,
    required this.expanded,
    required this.feedbackCell,
    required this.onToggle,
    required this.onDragUpdate,
    required this.onDragEnd,
    required this.onSelect,
    required this.onDragStarted,
  });

  final ui.Image image;
  final PuzzleController controller;
  final ScrollController scrollController;
  final bool expanded;
  final double feedbackCell;
  final VoidCallback onToggle;
  final GestureDragUpdateCallback onDragUpdate;
  final GestureDragEndCallback onDragEnd;
  final ValueChanged<int> onSelect;
  final VoidCallback onDragStarted;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: const Color(0xFBFFFFFF),
      borderRadius: BorderRadius.circular(27),
      border: Border.all(color: const Color(0xDDEBEBE8)),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0A393C35),
          blurRadius: 24,
          offset: Offset(0, -4),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(27),
      child: CustomScrollView(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(
          parent: ClampingScrollPhysics(),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: PieceSheetHeader(
              remaining: controller.game.remaining.length,
              total: controller.game.total,
              expanded: expanded,
              onDragUpdate: onDragUpdate,
              onDragEnd: onDragEnd,
              onToggle: onToggle,
            ),
          ),
          if (expanded)
            PuzzlePieceGrid(
              image: image,
              controller: controller,
              feedbackCell: feedbackCell,
              onSelect: onSelect,
              onDragStarted: onDragStarted,
            )
          else
            SliverToBoxAdapter(
              child: PieceStrip(
                image: image,
                controller: controller,
                feedbackCell: feedbackCell,
              ),
            ),
          SliverToBoxAdapter(
            child: PieceSheetHint(
              controller: controller,
              onRestart: () => controller.restart(),
            ),
          ),
          if (expanded) const SliverToBoxAdapter(child: SizedBox(height: 18)),
        ],
      ),
    ),
  );
}
