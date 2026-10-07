import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/puzzle_settings_controller.dart';
import '../widgets/puzzle_settings_content.dart';
import '../widgets/puzzle_settings_header.dart';
import '../widgets/start_puzzle_button.dart';

class PuzzleSettingsPage extends ConsumerWidget {
  const PuzzleSettingsPage({super.key});

  Future<void> _pick(
    BuildContext context,
    WidgetRef ref, {
    required bool camera,
  }) async {
    final message = await ref
        .read(puzzleSettingsControllerProvider.notifier)
        .pickImage(camera: camera);
    if (!context.mounted || message == null) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    backgroundColor: const Color(0xFFF8F7F3),
    body: SafeArea(
      bottom: false,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            children: [
              PuzzleSettingsHeader(onBack: () => Navigator.of(context).pop()),
              Expanded(
                child: PuzzleSettingsContent(
                  onGallery: () => _pick(context, ref, camera: false),
                  onCamera: () => _pick(context, ref, camera: true),
                ),
              ),
              StartPuzzleButton(
                busy: ref.watch(puzzleSettingsControllerProvider),
                bottomInset: MediaQuery.paddingOf(context).bottom,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
