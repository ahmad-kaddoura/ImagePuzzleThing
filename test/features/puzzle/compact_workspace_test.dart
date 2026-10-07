import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_puzzle/features/puzzle/presentation/controllers/puzzle_controller.dart';
import 'package:image_puzzle/features/puzzle/presentation/controllers/puzzle_feedback.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/compact_puzzle_workspace.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/puzzle_board.dart';

void main() {
  for (final size in [
    const Size(320, 620),
    const Size(390, 740),
    const Size(430, 820),
  ]) {
    testWidgets('board and tray remain accessible at $size', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final recorder = ui.PictureRecorder();
      Canvas(recorder).drawColor(Colors.teal, BlendMode.src);
      final picture = recorder.endRecording();
      final image = await picture.toImage(300, 300);
      picture.dispose();
      final controller = PuzzleController();
      final feedback = PuzzleFeedback()
        ..soundEnabled = false
        ..hapticsEnabled = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: CompactPuzzleWorkspace(
                image: image,
                title: 'Lakeside daydream',
                controller: controller,
                feedback: feedback,
                onFeedbackChanged: () {},
                onPlace: controller.place,
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      final board = tester.getRect(find.byType(PuzzleBoard));
      expect(board.width, closeTo(board.height, .01));
      expect(
        board.bottom,
        lessThan(tester.getTopLeft(find.text('Your pieces')).dy),
      );
      expect(
        tester
            .getBottomLeft(
              find.text('Drag into place, or tap a piece then a space.'),
            )
            .dy,
        lessThan(size.height),
      );
      await tester.pumpWidget(const SizedBox());
      controller.dispose();
      feedback.dispose();
      image.dispose();
    });
  }
}
