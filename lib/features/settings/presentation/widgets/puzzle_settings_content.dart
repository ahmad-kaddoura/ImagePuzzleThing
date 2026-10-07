import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_puzzle/core/providers/puzzle_session_provider.dart';
import 'package:image_puzzle/core/models/puzzle_session_settings.dart';

import '../controllers/puzzle_settings_controller.dart';
import 'puzzle_additional_options.dart';
import 'puzzle_difficulty_options.dart';
import 'puzzle_image_options.dart';
import 'puzzle_style_options.dart';

class PuzzleSettingsContent extends ConsumerWidget {
  const PuzzleSettingsContent({
    super.key,
    required this.onGallery,
    required this.onCamera,
  });
  final VoidCallback onGallery;
  final VoidCallback onCamera;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(puzzleSessionProvider);
    final busy = ref.watch(puzzleSettingsControllerProvider);
    final controller = ref.read(puzzleSettingsControllerProvider.notifier);
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 6, 18, 14),
      children: [
        PuzzleImageOptions(
          image: settings.imageSource != PuzzleImageSource.sample
              ? settings.image
              : const AssetImage('assets/images/lakeside_reference.png'),
          sampleImage: settings.imageSource == PuzzleImageSource.sample
              ? settings.image
              : const AssetImage('assets/images/lakeside_reference.png'),
          source: settings.imageSource,
          busy: busy,
          onGallery: onGallery,
          onSample: controller.useSample,
          onCamera: onCamera,
        ),
        const SizedBox(height: 12),
        PuzzleDifficultyOptions(
          selected: settings.difficulty,
          layout: settings.layout,
          onSelected: (value) =>
              controller.update(settings.copyWith(difficulty: value)),
        ),
        const SizedBox(height: 12),
        PuzzleStyleOptions(
          selected: settings.layout,
          onSelected: (value) =>
              controller.update(settings.copyWith(layout: value)),
        ),
        const SizedBox(height: 12),
        PuzzleAdditionalOptions(
          preview: settings.showPiecePreview,
          snap: settings.snapToPosition,
          highlights: settings.highlightMatchingAreas,
          onPreviewChanged: (value) =>
              controller.update(settings.copyWith(showPiecePreview: value)),
          onSnapChanged: (value) =>
              controller.update(settings.copyWith(snapToPosition: value)),
          onHighlightsChanged: (value) => controller.update(
            settings.copyWith(highlightMatchingAreas: value),
          ),
        ),
      ],
    );
  }
}
