import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_puzzle/features/puzzle/presentation/controllers/puzzle_controller.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/piece_grid_tile.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/piece_strip.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/piece_tile.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/scenic_puzzle_scene.dart';

void main() {
  testWidgets(
    'expanded grid retains placed pieces, disables them, and collapses on selection',
    (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      final semantics = tester.ensureSemantics();
      final recorder = ui.PictureRecorder();
      Canvas(recorder).drawColor(Colors.teal, BlendMode.src);
      final picture = recorder.endRecording();
      final image = await picture.toImage(300, 300);
      picture.dispose();
      final controller = PuzzleController(dimension: 5);
      final placed = controller.game.order.first;
      controller.place(placed, placed);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListenableBuilder(
              listenable: controller,
              builder: (context, child) => ScenicPuzzleScene(
                image: image,
                title: 'Lakeside daydream',
                controller: controller,
                onSettings: () {},
                onPlace: controller.place,
              ),
            ),
          ),
        ),
      );
      expect(find.text('24 left'), findsOneWidget);
      expect(find.byType(PieceStrip), findsOneWidget);
      await tester.drag(
        find.byKey(const ValueKey('piece-sheet-handle')),
        const Offset(0, -400),
      );
      await tester.pumpAndSettle();
      expect(find.text('1 placed · 25 pieces in all'), findsOneWidget);
      final placedTile = find.byKey(ValueKey('grid-piece-$placed'));
      expect(placedTile, findsOneWidget);
      final tile = tester.widget<PieceTile>(
        find.descendant(of: placedTile, matching: find.byType(PieceTile)),
      );
      expect(tile.used, isTrue);
      expect(
        find.descendant(of: placedTile, matching: find.byType(ColorFiltered)),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: placedTile,
          matching: find.byType(LongPressDraggable<int>),
        ),
        findsNothing,
      );
      await tester.tap(placedTile);
      await tester.pump();
      expect(controller.selected, isNull);
      expect(find.byType(PieceGridTile), findsWidgets);
      final remaining = controller.game.order[1];
      await tester.tap(find.byKey(ValueKey('grid-piece-$remaining')));
      await tester.pumpAndSettle();
      expect(controller.selected, remaining);
      expect(find.byType(PieceStrip), findsOneWidget);
      expect(find.byType(PieceGridTile), findsNothing);
      expect(find.byKey(ValueKey('strip-piece-$remaining')), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('piece-sheet-handle')));
      await tester.pumpAndSettle();
      expect(find.byType(PieceGridTile), findsWidgets);
      await tester.drag(
        find.byKey(const ValueKey('piece-sheet-handle')),
        const Offset(0, 550),
      );
      await tester.pumpAndSettle();
      expect(find.byType(PieceStrip), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      controller.dispose();
      image.dispose();
      semantics.dispose();
    },
  );
}
