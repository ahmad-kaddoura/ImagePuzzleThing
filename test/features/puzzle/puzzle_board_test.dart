import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_puzzle/core/domain/puzzle_layout.dart';
import 'package:image_puzzle/features/puzzle/presentation/controllers/puzzle_controller.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/piece_tile.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/puzzle_board.dart';

void main() {
  for (final layout in PuzzleLayout.values) {
    testWidgets(
      '${layout.label} supports dragging, tapping, and preview protection',
      (tester) async {
        final recorder = ui.PictureRecorder();
        Canvas(recorder).drawRect(
          const Rect.fromLTWH(0, 0, 300, 300),
          Paint()..color = Colors.teal,
        );
        final picture = recorder.endRecording();
        final image = await picture.toImage(300, 300);
        picture.dispose();
        final controller = PuzzleController()..restart(layout: layout);
        final boardKey = GlobalKey();
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ListenableBuilder(
                listenable: controller,
                builder: (context, child) => Column(
                  children: [
                    SizedBox(
                      key: boardKey,
                      width: 300,
                      child: PuzzleBoard(
                        image: image,
                        controller: controller,
                        onPlace: controller.place,
                      ),
                    ),
                    if (!controller.game.isPlaced(0))
                      PieceTile(
                        image: image,
                        id: 0,
                        dimension: 3,
                        layout: layout,
                        selected: controller.selected == 0,
                        onTap: () => controller.select(0),
                        cell: 50,
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
        final origin = tester.getTopLeft(find.byKey(boardKey));
        await tester.dragFrom(
          tester.getCenter(find.byType(PieceTile)),
          origin +
              const Offset(25, 25) -
              tester.getCenter(find.byType(PieceTile)),
        );
        await tester.pumpAndSettle();
        expect(controller.game.isPlaced(0), isTrue);
        final next = layout == PuzzleLayout.triangles
            ? const Offset(75, 75)
            : const Offset(150, 50);
        controller.select(1);
        await tester.pump();
        controller.togglePreview();
        await tester.pump();
        await tester.tapAt(origin + next);
        expect(controller.game.isPlaced(1), isFalse);
        controller.togglePreview();
        await tester.pump();
        await tester.tapAt(origin + next);
        await tester.pumpAndSettle();
        expect(controller.game.isPlaced(1), isTrue);
        expect(controller.selected, isNull);
        await tester.pumpWidget(const SizedBox());
        controller.dispose();
        image.dispose();
      },
    );
  }
}
