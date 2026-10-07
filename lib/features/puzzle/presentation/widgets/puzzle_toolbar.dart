import 'package:flutter/material.dart';

import '../controllers/puzzle_controller.dart';
import '../controllers/puzzle_feedback.dart';

class PuzzleToolbar extends StatelessWidget {
  const PuzzleToolbar({
    super.key,
    required this.controller,
    required this.feedback,
    required this.onFeedbackChanged,
  });

  final PuzzleController controller;
  final PuzzleFeedback feedback;
  final VoidCallback onFeedbackChanged;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: [
      SegmentedButton<int>(
        showSelectedIcon: false,
        segments: const [
          ButtonSegment(value: 3, label: Text('Easy')),
          ButtonSegment(value: 4, label: Text('Medium')),
          ButtonSegment(value: 5, label: Text('Hard')),
        ],
        selected: {controller.game.dimension},
        onSelectionChanged: (values) =>
            controller.restart(dimension: values.first),
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
      ),
      IconButton.filledTonal(
        onPressed: controller.togglePreview,
        isSelected: controller.preview,
        tooltip: controller.preview ? 'Hide preview' : 'Preview image',
        icon: Icon(
          controller.preview
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        ),
      ),
      IconButton.filledTonal(
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
