import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_puzzle/core/models/puzzle_session_settings.dart';
import 'package:image_puzzle/core/providers/puzzle_session_provider.dart';
import 'package:image_puzzle/features/settings/domain/puzzle_image_gateway.dart';
import 'package:image_puzzle/features/settings/presentation/controllers/puzzle_settings_controller.dart';

const initial = PuzzleSessionSettings(
  image: AssetImage('assets/images/lakeside_reference.png'),
  title: 'Lakeside daydream',
  soundEnabled: false,
  hapticsEnabled: false,
);

class DeferredPicker implements PuzzleImageGateway {
  final result = Completer<PickedPuzzleImage?>();
  @override
  Future<PickedPuzzleImage?> fromGallery() => result.future;
  @override
  Future<PickedPuzzleImage?> fromCamera() => result.future;
  @override
  Future<PickedPuzzleImage?> recoverLostImage() async => null;
}

ProviderContainer createContainer(DeferredPicker picker) {
  final container = ProviderContainer(
    overrides: [imagePickerGatewayProvider.overrideWithValue(picker)],
  );
  container.read(puzzleSessionProvider.notifier).update(initial);
  container.listen(puzzleSettingsControllerProvider, (_, _) {});
  return container;
}

void main() {
  test(
    'Medium is the initial difficulty and updates are shared immediately',
    () {
      final container = ProviderContainer();
      addTearDown(container.dispose);
      expect(
        container.read(puzzleSessionProvider).difficulty,
        PuzzleDifficulty.medium,
      );
      final controller = container.read(
        puzzleSettingsControllerProvider.notifier,
      );
      controller.update(
        container
            .read(puzzleSessionProvider)
            .copyWith(difficulty: PuzzleDifficulty.expert),
      );
      expect(
        container.read(puzzleSessionProvider).difficulty,
        PuzzleDifficulty.expert,
      );
    },
  );

  test('canceling preserves the session and sample selection preserves preferences', () async {
    final picker = DeferredPicker();
    final container = createContainer(picker);
    addTearDown(container.dispose);
    final controller = container.read(
      puzzleSettingsControllerProvider.notifier,
    );
    final picking = controller.pickImage(camera: false);
    expect(container.read(puzzleSettingsControllerProvider), isTrue);
    controller.useSample();
    expect(container.read(puzzleSessionProvider), same(initial));
    picker.result.complete(null);
    expect(await picking, isNull);
    expect(container.read(puzzleSettingsControllerProvider), isFalse);
    expect(container.read(puzzleSessionProvider), same(initial));
    controller.useSample();
    final selected = container.read(puzzleSessionProvider);
    expect(selected.title, 'Golden hour');
    expect(selected.soundEnabled, isFalse);
    expect(selected.hapticsEnabled, isFalse);
  });

  test(
    'camera selection changes the image and retains the difficulty',
    () async {
      final picker = DeferredPicker();
      final container = createContainer(picker);
      addTearDown(container.dispose);
      container
          .read(puzzleSessionProvider.notifier)
          .update(initial.copyWith(difficulty: PuzzleDifficulty.expert));
      final picking = container
          .read(puzzleSettingsControllerProvider.notifier)
          .pickImage(camera: true);
      picker.result.complete(
        PickedPuzzleImage(bytes: Uint8List.fromList([1]), name: 'photo.jpg'),
      );
      expect(await picking, isNull);
      final selected = container.read(puzzleSessionProvider);
      expect(selected.imageSource, PuzzleImageSource.camera);
      expect(selected.image, isA<MemoryImage>());
      expect(selected.difficulty, PuzzleDifficulty.expert);
    },
  );

  test('picker errors clear loading and keep the current image', () async {
    final picker = DeferredPicker();
    final container = createContainer(picker);
    addTearDown(container.dispose);
    final picking = container
        .read(puzzleSettingsControllerProvider.notifier)
        .pickImage(camera: false);
    picker.result.completeError(
      const PuzzleImagePickerException('Choose another photo'),
    );
    expect(await picking, 'Choose another photo');
    expect(container.read(puzzleSettingsControllerProvider), isFalse);
    expect(container.read(puzzleSessionProvider), same(initial));
  });

  test('disposed picker ignores a later result', () async {
    final picker = DeferredPicker();
    final container = createContainer(picker);
    final picking = container
        .read(puzzleSettingsControllerProvider.notifier)
        .pickImage(camera: false);
    container.dispose();
    picker.result.complete(
      PickedPuzzleImage(bytes: Uint8List.fromList([1]), name: 'photo.jpg'),
    );
    expect(await picking, isNull);
  });
}
