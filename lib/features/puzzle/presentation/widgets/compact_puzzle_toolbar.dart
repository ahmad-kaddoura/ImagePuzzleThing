import 'package:flutter/material.dart';

import '../controllers/puzzle_controller.dart';
import '../controllers/puzzle_feedback.dart';

class CompactPuzzleToolbar extends StatelessWidget {
  const CompactPuzzleToolbar({
    super.key,
    required this.controller,
    required this.feedback,
    required this.onFeedbackChanged,
  });

  final PuzzleController controller;
  final PuzzleFeedback feedback;
  final VoidCallback onFeedbackChanged;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      PopupMenuButton<int>(
        tooltip: 'Choose difficulty',
        initialValue: controller.game.dimension,
        onSelected: (value) => controller.restart(dimension: value),
        itemBuilder: (context) => const [
          PopupMenuItem(value: 3, child: Text('Easy')),
          PopupMenuItem(value: 4, child: Text('Medium')),
          PopupMenuItem(value: 5, child: Text('Hard')),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: Row(
            children: [
              Text(switch (controller.game.dimension) {
                3 => 'Easy',
                4 => 'Medium',
                _ => 'Hard',
              }, style: const TextStyle(fontWeight: FontWeight.w600)),
              const Icon(Icons.keyboard_arrow_down_rounded, size: 18),
            ],
          ),
        ),
      ),
      const Spacer(),
      IconButton(
        onPressed: controller.togglePreview,
        tooltip: controller.preview ? 'Hide preview' : 'Preview image',
        icon: Icon(
          controller.preview
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        ),
      ),
      IconButton(
        onPressed: () => controller.restart(),
        tooltip: 'Restart puzzle',
        icon: const Icon(Icons.refresh_rounded),
      ),
      IconButton(
        onPressed: () {
          feedback.soundEnabled = !feedback.soundEnabled;
          onFeedbackChanged();
        },
        tooltip: feedback.soundEnabled ? 'Mute sound' : 'Enable sound',
        icon: Icon(
          feedback.soundEnabled
              ? Icons.volume_up_outlined
              : Icons.volume_off_outlined,
        ),
      ),
      IconButton(
        onPressed: () {
          feedback.hapticsEnabled = !feedback.hapticsEnabled;
          onFeedbackChanged();
        },
        tooltip: feedback.hapticsEnabled ? 'Disable haptics' : 'Enable haptics',
        icon: Icon(
          feedback.hapticsEnabled
              ? Icons.vibration_rounded
              : Icons.smartphone_rounded,
        ),
      ),
    ],
  );
}
