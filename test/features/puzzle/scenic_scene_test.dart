import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_puzzle/features/puzzle/presentation/controllers/puzzle_controller.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/piece_sheet_header.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/puzzle_board.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/puzzle_counters.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/puzzle_board_frame.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/scenic_puzzle_scene.dart';

void main() {
  for (final size in [
    const Size(320, 620),
    const Size(390, 844),
    const Size(430, 932),
    const Size(852, 393),
  ]) {
    testWidgets('reference scene keeps board and sheet reachable at $size', (
      tester,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final recorder = ui.PictureRecorder();
      Canvas(recorder).drawColor(Colors.teal, BlendMode.src);
      final picture = recorder.endRecording();
      final image = await picture.toImage(300, 300);
      picture.dispose();
      final controller = PuzzleController(dimension: 5);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ScenicPuzzleScene(
              image: image,
              title: 'Lakeside daydream',
              controller: controller,
              onSettings: () {},
              onPlace: controller.place,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      final board = tester.getRect(find.byType(PuzzleBoard));
      expect(board.width, closeTo(board.height, .01));
      expect(board.bottom, lessThan(size.height));
      if (size.width < size.height) {
        expect(
          board.bottom,
          lessThan(tester.getTopLeft(find.byType(PieceSheetHeader)).dy),
        );
      }
      expect(
        tester.getRect(find.byType(PuzzleCounters)).top,
        lessThan(board.top),
      );
      final counters = tester.getRect(find.byType(PuzzleCounters));
      final frame = tester.getRect(find.byType(PuzzleBoardFrame));
      expect(frame.top - counters.bottom, greaterThanOrEqualTo(12));
      expect(find.text('25 left'), findsOneWidget);
      await tester.pumpWidget(const SizedBox());
      controller.dispose();
      image.dispose();
    });
  }
}
