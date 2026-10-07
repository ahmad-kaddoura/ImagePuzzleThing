import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_puzzle/app/pages/puzzle_page.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/image_puzzle.dart';
import 'package:image_puzzle/features/settings/presentation/controllers/puzzle_settings_controller.dart';

import 'settings_layout_test.dart' show CancelingPicker;

void main() {
  testWidgets(
    'settings difficulty reaches the puzzle without returning a route result',
    (tester) async {
      tester.view.physicalSize = const Size(402, 874);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            imagePickerGatewayProvider.overrideWithValue(CancelingPicker()),
          ],
          child: const MaterialApp(home: PuzzlePage()),
        ),
      );
      await tester.runAsync(
        () => precacheImage(
          ResizeImage(
            const AssetImage('assets/images/lakeside_reference.png'),
            width: 1600,
            height: 1600,
            policy: ResizeImagePolicy.fit,
          ),
          tester.element(find.byType(PuzzlePage)),
        ),
      );
      await tester.pumpAndSettle();
      expect(
        tester.widget<ImagePuzzle>(find.byType(ImagePuzzle)).initialDimension,
        5,
      );
      await tester.tap(find.byTooltip('Puzzle settings'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Expert'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Start Puzzle'));
      await tester.pumpAndSettle();
      expect(
        tester.widget<ImagePuzzle>(find.byType(ImagePuzzle)).initialDimension,
        10,
      );
      expect(find.text('0 / 100'), findsOneWidget);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
}
