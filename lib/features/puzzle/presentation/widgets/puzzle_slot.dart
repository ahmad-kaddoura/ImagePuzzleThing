import 'dart:ui' as ui;
import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/puzzle_layout.dart';
import '../controllers/puzzle_controller.dart';
import 'piece_path.dart';
import 'puzzle_piece.dart';
import 'slot_clipper.dart';

class PuzzleSlot extends StatelessWidget {
  const PuzzleSlot({
    super.key,
    required this.image,
    required this.id,
    required this.cell,
    required this.controller,
    required this.onPlace,
  });

  final ui.Image image;
  final int id;
  final double cell;
  final PuzzleController controller;
  final void Function(int, int) onPlace;

  @override
  Widget build(BuildContext context) {
    final game = controller.game;
    final placed = game.isPlaced(id);
    final pad = cell * PiecePath.padding;
    final rejected = controller.rejectedSlot == id;
    final target = DragTarget<int>(
      onWillAcceptWithDetails: (details) => !placed && !controller.preview,
      onAcceptWithDetails: (details) => onPlace(details.data, id),
      builder: (context, candidates, rejectedData) => Semantics(
        button: !placed,
        label: 'Slot ${id + 1}${placed ? ', filled' : ''}',
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: placed || controller.preview
              ? null
              : () {
                  final selected = controller.selected;
                  if (selected != null) onPlace(selected, id);
                },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: -pad,
                top: -pad,
                child: TweenAnimationBuilder<double>(
                  key: ValueKey('$id-$placed-$rejected'),
                  tween: Tween(
                    begin: placed
                        ? .86
                        : rejected
                        ? 0
                        : 1,
                    end: 1,
                  ),
                  duration: Duration(
                    milliseconds: MediaQuery.disableAnimationsOf(context)
                        ? 0
                        : 260,
                  ),
                  curve: rejected ? Curves.easeOut : Curves.easeOutBack,
                  builder: (context, scale, child) => Transform.translate(
                    offset: Offset(
                      rejected ? sin(scale * pi * 4) * (1 - scale) * 8 : 0,
                      0,
                    ),
                    child: Transform.scale(
                      scale: placed ? scale : 1,
                      child: child,
                    ),
                  ),
                  child: PuzzlePiece(
                    image: image,
                    id: id,
                    dimension: game.dimension,
                    layout: game.layout,
                    cell: cell,
                    ghost: !placed,
                  ),
                ),
              ),
              if (candidates.isNotEmpty)
                ClipPath(
                  clipper: SlotClipper(
                    id: id,
                    dimension: game.dimension,
                    layout: game.layout,
                  ),
                  child: ColoredBox(
                    color: candidates.first == id
                        ? const Color(0x5524786C)
                        : const Color(0x55DFA486),
                    child: SizedBox.square(dimension: cell),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
    return game.layout == PuzzleLayout.triangles
        ? ClipPath(
            clipper: SlotClipper(
              id: id,
              dimension: game.dimension,
              layout: game.layout,
            ),
            child: target,
          )
        : target;
  }
}
