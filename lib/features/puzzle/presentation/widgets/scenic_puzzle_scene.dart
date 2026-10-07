import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../controllers/puzzle_controller.dart';
import 'puzzle_backdrop.dart';
import 'puzzle_board_frame.dart';
import 'puzzle_counters.dart';
import 'puzzle_pieces_sheet.dart';
import 'scenic_puzzle_header.dart';

class ScenicPuzzleScene extends StatelessWidget {
  const ScenicPuzzleScene({
    super.key,
    required this.image,
    required this.title,
    required this.controller,
    required this.onSettings,
    required this.onPlace,
  });

  final ui.Image image;
  final String title;
  final PuzzleController controller;
  final VoidCallback onSettings;
  final void Function(int, int) onPlace;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;
      final safe = MediaQuery.paddingOf(context);
      final landscape = width > height;
      final contentWidth = min(width, 520.0);
      final inset = max(12.0, safe.bottom * .45);
      final headerTop = max(safe.top + 8, height * .078);
      final collapsedHeight = max(180.0, min(190.0, contentWidth * .44));
      final boardTop = landscape
          ? headerTop + 122
          : max(headerTop + 116, height * .335);
      final boardSide = landscape
          ? min(height - boardTop - inset, width * .46 - 24)
          : min(
              contentWidth - 26,
              height - boardTop - collapsedHeight - inset - 12,
            );
      final boardLeft = landscape ? 18.0 : (width - boardSide) / 2;
      final sheetLeft = landscape ? width * .53 : (width - contentWidth) / 2;
      final sheetWidth = landscape ? width * .47 - 18 : contentWidth;
      return Stack(
        children: [
          Positioned.fill(child: PuzzleBackdrop(image: image)),
          Positioned(
            top: headerTop,
            left: (width - contentWidth) / 2 + 18,
            width: contentWidth - 36,
            child: ScenicPuzzleHeader(title: title, onSettings: onSettings),
          ),
          Positioned(
            top: boardTop - 72,
            left: boardLeft,
            width: boardSide,
            child: PuzzleCounters(controller: controller),
          ),
          Positioned(
            top: boardTop,
            left: boardLeft,
            width: boardSide,
            height: boardSide,
            child: PuzzleBoardFrame(
              image: image,
              controller: controller,
              onPlace: onPlace,
            ),
          ),
          Positioned(
            top: landscape ? headerTop + 62 : 0,
            bottom: inset,
            left: sheetLeft,
            width: sheetWidth,
            child: PuzzlePiecesSheet(
              image: image,
              controller: controller,
              collapsedHeight: collapsedHeight,
              feedbackCell: (boardSide - 20) / controller.game.dimension,
            ),
          ),
        ],
      );
    },
  );
}
