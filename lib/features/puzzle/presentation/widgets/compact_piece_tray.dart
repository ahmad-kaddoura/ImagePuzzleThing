import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../controllers/puzzle_controller.dart';
import 'piece_tile.dart';

class CompactPieceTray extends StatelessWidget {
  const CompactPieceTray({
    super.key,
    required this.image,
    required this.controller,
    required this.feedbackCell,
  });

  final ui.Image image;
  final PuzzleController controller;
  final double feedbackCell;

  @override
  Widget build(BuildContext context) {
    final pieces = controller.game.remaining;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE6E9E1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                controller.game.isComplete
                    ? 'Beautifully done. ✨'
                    : 'Your pieces',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Text(
                '${pieces.length} left',
                style: const TextStyle(fontSize: 12, color: Color(0xFF74837B)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 84,
            child: controller.game.isComplete
                ? Center(
                    child: FilledButton.icon(
                      onPressed: () => controller.restart(),
                      icon: const Icon(Icons.replay_rounded),
                      label: const Text('Play again'),
                    ),
                  )
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: pieces.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final id = pieces[index];
                      return PieceTile(
                        image: image,
                        id: id,
                        dimension: controller.game.dimension,
                        layout: controller.game.layout,
                        selected: controller.selected == id,
                        onTap: () => controller.select(id),
                        cell: 50,
                        feedbackCell: feedbackCell,
                      );
                    },
                  ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Drag into place, or tap a piece then a space.',
            style: TextStyle(fontSize: 11, color: Color(0xFF74837B)),
          ),
        ],
      ),
    );
  }
}
