import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_puzzle/core/models/puzzle_session_settings.dart';
import 'package:image_puzzle/core/providers/puzzle_session_provider.dart';

import '../../domain/puzzle_image_gateway.dart';

final imagePickerGatewayProvider = Provider<PuzzleImageGateway>(
  (ref) =>
      throw StateError('Provide a puzzle image picker at app composition.'),
);
final puzzleSettingsControllerProvider =
    NotifierProvider.autoDispose<PuzzleSettingsController, bool>(
      PuzzleSettingsController.new,
    );

class PuzzleSettingsController extends Notifier<bool> {
  @override
  bool build() => false;

  void update(PuzzleSessionSettings settings) {
    if (state) return;
    ref.read(puzzleSessionProvider.notifier).update(settings);
  }

  void useSample() {
    final settings = ref.read(puzzleSessionProvider);
    final alternate = settings.title == 'Lakeside daydream';
    update(
      settings.copyWith(
        image: AssetImage(
          alternate
              ? 'assets/images/lakeside.png'
              : 'assets/images/lakeside_reference.png',
        ),
        title: alternate ? 'Golden hour' : 'Lakeside daydream',
        imageSource: PuzzleImageSource.sample,
      ),
    );
  }

  Future<String?> pickImage({required bool camera}) async {
    if (state) return null;
    state = true;
    final picker = ref.read(imagePickerGatewayProvider);
    try {
      final photo = camera
          ? await picker.fromCamera()
          : await picker.fromGallery();
      if (photo != null && ref.mounted) {
        final settings = ref.read(puzzleSessionProvider);
        ref
            .read(puzzleSessionProvider.notifier)
            .update(
              settings.copyWith(
                image: MemoryImage(photo.bytes),
                title: 'Your photo',
                imageSource: camera
                    ? PuzzleImageSource.camera
                    : PuzzleImageSource.gallery,
              ),
            );
      }
      return null;
    } on PuzzleImagePickerException catch (error) {
      return error.message;
    } catch (_) {
      return 'The photo could not be opened. Please try again.';
    } finally {
      if (ref.mounted) state = false;
    }
  }
}
