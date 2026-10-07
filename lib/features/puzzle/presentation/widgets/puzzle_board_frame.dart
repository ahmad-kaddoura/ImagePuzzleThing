import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../controllers/puzzle_controller.dart';
import 'puzzle_board.dart';

class PuzzleBoardFrame extends StatelessWidget {
  const PuzzleBoardFrame({
    super.key,
    required this.image,
    required this.controller,
    required this.onPlace,
    required this.onDrop,
  });

  final ui.Image image;
  final PuzzleController controller;
  final void Function(int, int) onPlace;
  final void Function(int, int) onDrop;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xF5FFFFFF),
      borderRadius: BorderRadius.circular(18),
      boxShadow: const [
        BoxShadow(
          color: Color(0x0C544F47),
          blurRadius: 24,
          offset: Offset(0, 10),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFDADFD5)),
        ),
        child: PuzzleBoard(
          image: image,
          controller: controller,
          onPlace: onPlace,
          onDrop: onDrop,
        ),
      ),
    ),
  );
}
