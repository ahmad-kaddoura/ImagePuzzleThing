import 'dart:math';

import 'package:flutter/material.dart';

import '../../domain/puzzle_layout.dart';
import '../controllers/puzzle_controller.dart';
import '../controllers/puzzle_feedback.dart';

class PuzzleSettingsPanel extends StatefulWidget {
  const PuzzleSettingsPanel({
    super.key,
    required this.controller,
    required this.feedback,
    this.onChangeImage,
  });

  final PuzzleController controller;
  final PuzzleFeedback feedback;
  final VoidCallback? onChangeImage;

  @override
  State<PuzzleSettingsPanel> createState() => _PuzzleSettingsPanelState();
}

class _PuzzleSettingsPanelState extends State<PuzzleSettingsPanel> {
  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        24,
        0,
        24,
        24 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: ListenableBuilder(
        listenable: widget.controller,
        builder: (context, child) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Puzzle settings',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 22),
            const Text('Layout', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: SegmentedButton<PuzzleLayout>(
                showSelectedIcon: false,
                segments: [
                  for (final layout in PuzzleLayout.values)
                    ButtonSegment(value: layout, label: Text(layout.label)),
                ],
                selected: {widget.controller.game.layout},
                onSelectionChanged: (values) =>
                    widget.controller.restart(layout: values.first),
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Difficulty',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: SegmentedButton<int>(
                showSelectedIcon: false,
                segments: const [
                  ButtonSegment(value: 3, label: Text('Easy')),
                  ButtonSegment(value: 4, label: Text('Medium')),
                  ButtonSegment(value: 5, label: Text('Hard')),
                ],
                selected: {widget.controller.game.dimension},
                onSelectionChanged: (values) =>
                    widget.controller.restart(dimension: values.first),
              ),
            ),
            const SizedBox(height: 16),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: const Text('Preview image'),
              value: widget.controller.preview,
              onChanged: (_) => widget.controller.togglePreview(),
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: const Text('Sound'),
              value: widget.feedback.soundEnabled,
              onChanged: (value) =>
                  setState(() => widget.feedback.soundEnabled = value),
            ),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: const Text('Haptics'),
              value: widget.feedback.hapticsEnabled,
              onChanged: (value) =>
                  setState(() => widget.feedback.hapticsEnabled = value),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                if (widget.onChangeImage != null)
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      widget.onChangeImage!();
                    },
                    icon: const Icon(Icons.add_photo_alternate_outlined),
                    label: const Text('Your image'),
                  ),
                OutlinedButton.icon(
                  onPressed: () {
                    final choices = PuzzleLayout.values
                        .where(
                          (layout) => layout != widget.controller.game.layout,
                        )
                        .toList();
                    widget.controller.restart(
                      layout: choices[Random().nextInt(choices.length)],
                    );
                  },
                  icon: const Icon(Icons.shuffle_rounded),
                  label: const Text('Random layout'),
                ),
                FilledButton.icon(
                  onPressed: () {
                    widget.controller.restart();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Restart puzzle'),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
