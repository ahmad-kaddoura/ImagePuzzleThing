import 'package:flutter/material.dart';

import '../controllers/puzzle_controller.dart';

class PieceSheetHint extends StatelessWidget {
  const PieceSheetHint({
    super.key,
    required this.controller,
    required this.onRestart,
  });

  final PuzzleController controller;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
    child: Semantics(
      liveRegion: controller.game.isComplete || controller.rejectedSlot != null,
      child: Material(
        color: const Color(0xFFF3F2EF),
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          onTap: controller.game.isComplete ? onRestart : null,
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  controller.game.isComplete
                      ? Icons.replay_rounded
                      : Icons.lightbulb_outline_rounded,
                  size: 19,
                  color: const Color(0xFF75858C),
                ),
                const SizedBox(width: 9),
                Flexible(
                  child: Text(
                    controller.game.isComplete
                        ? 'Beautifully done. Play again'
                        : controller.rejectedSlot != null
                        ? 'Try another space'
                        : controller.preview
                        ? 'Hide the preview to keep playing'
                        : 'Drag a piece to the board',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF7C8A90),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
