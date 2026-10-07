import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_puzzle/core/providers/puzzle_session_provider.dart';

import '../../features/settings/presentation/controllers/puzzle_settings_controller.dart';

import '../../features/settings/domain/puzzle_image_gateway.dart';

import 'package:image_puzzle/core/models/puzzle_session_settings.dart';

import '../../features/puzzle/presentation/widgets/image_puzzle.dart';
import '../../features/settings/presentation/pages/puzzle_settings_page.dart';

class PuzzlePage extends ConsumerStatefulWidget {
  const PuzzlePage({super.key});

  @override
  ConsumerState<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends ConsumerState<PuzzlePage> {
  @override
  void initState() {
    super.initState();
    if (defaultTargetPlatform == TargetPlatform.android) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _restorePickerResult(),
      );
    }
  }

  Future<void> _restorePickerResult() async {
    try {
      final photo = await ref
          .read(imagePickerGatewayProvider)
          .recoverLostImage();
      if (photo == null || !mounted) return;
      final settings = ref.read(puzzleSessionProvider);
      ref
          .read(puzzleSessionProvider.notifier)
          .update(
            settings.copyWith(
              image: MemoryImage(photo.bytes),
              title: 'Your photo',
              imageSource: PuzzleImageSource.gallery,
            ),
          );
      await _openSettings();
    } on PuzzleImagePickerException catch (error) {
      _showRecoveryError(error.message);
    } catch (_) {
      _showRecoveryError(
        'Your previous photo could not be recovered. Please choose it again.',
      );
    }
  }

  void _showRecoveryError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _openSettings() => Navigator.of(
    context,
  ).push<void>(MaterialPageRoute(builder: (_) => const PuzzleSettingsPage()));

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(puzzleSessionProvider);
    return Scaffold(
      body: ImagePuzzle(
        key: ValueKey((settings.image, settings.layout, settings.difficulty)),
        image: settings.image,
        title: settings.title,
        initialLayout: settings.layout,
        initialDimension: settings.difficulty.dimension,
        snapToPosition: settings.snapToPosition,
        showPiecePreview: settings.showPiecePreview,
        highlightMatchingAreas: settings.highlightMatchingAreas,
        soundEnabled: settings.soundEnabled,
        hapticsEnabled: settings.hapticsEnabled,
        onSettings: _openSettings,
      ),
    );
  }
}
