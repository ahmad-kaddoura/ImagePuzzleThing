import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../controllers/puzzle_controller.dart';
import 'puzzle_slot.dart';

class PuzzleBoard extends StatelessWidget {
  const PuzzleBoard({
    super.key,
    required this.image,
    required this.controller,
    required this.onPlace,
    this.onDrop,
  });

  final ui.Image image;
  final PuzzleController controller;
  final void Function(int, int) onPlace;
  final void Function(int, int)? onDrop;

  @override
  Widget build(BuildContext context) => AspectRatio(
    aspectRatio: 1,
    child: LayoutBuilder(
      builder: (context, constraints) {
        final game = controller.game;
        final cell = constraints.maxWidth / game.dimension;
        return DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0xFFE7E8E2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              for (var id = 0; id < game.total; id++)
                Positioned(
                  left: (game.layout.cellIndex(id) % game.dimension) * cell,
                  top: (game.layout.cellIndex(id) ~/ game.dimension) * cell,
                  width: cell,
                  height: cell,
                  child: PuzzleSlot(
                    image: image,
                    id: id,
                    cell: cell,
                    controller: controller,
                    onPlace: onPlace,
                    onDrop: onDrop ?? onPlace,
                  ),
                ),
              if (controller.preview)
                Positioned.fill(
                  child: IgnorePointer(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: RawImage(image: image, fit: BoxFit.cover),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    ),
  );
}
