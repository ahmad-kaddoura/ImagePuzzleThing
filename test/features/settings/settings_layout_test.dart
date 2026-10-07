import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_puzzle/features/settings/presentation/controllers/puzzle_settings_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_puzzle/features/settings/domain/puzzle_image_gateway.dart';
import 'package:image_puzzle/features/settings/presentation/pages/puzzle_settings_page.dart';

class CancelingPicker implements PuzzleImageGateway {
  @override
  Future<PickedPuzzleImage?> fromGallery() async => null;
  @override
  Future<PickedPuzzleImage?> fromCamera() async => null;
  @override
  Future<PickedPuzzleImage?> recoverLostImage() async => null;
}

void main() {
  for (final size in [
    const Size(320, 620),
    const Size(402, 874),
    const Size(740, 390),
  ]) {
    for (final scale in [1.0, 1.8]) {
      testWidgets(
        'settings can scroll without overflow at $size and scale $scale',
        (tester) async {
          tester.view.physicalSize = size;
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                imagePickerGatewayProvider.overrideWithValue(CancelingPicker()),
              ],
              child: MaterialApp(
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: TextScaler.linear(scale)),
                  child: child!,
                ),
                home: const PuzzleSettingsPage(),
              ),
            ),
          );
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
          await tester.scrollUntilVisible(
            find.text('Highlight matching areas'),
            300,
            scrollable: find.descendant(
              of: find.byType(ListView),
              matching: find.byType(Scrollable),
            ),
            maxScrolls: 30,
          );
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull);
          expect(find.text('Highlight matching areas'), findsOneWidget);
          expect(find.text('Start Puzzle').hitTestable(), findsOneWidget);
        },
      );
    }
  }
}
