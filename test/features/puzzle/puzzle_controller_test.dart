import 'package:flutter_test/flutter_test.dart';
import 'package:image_puzzle/features/puzzle/domain/puzzle_layout.dart';
import 'package:image_puzzle/features/puzzle/presentation/controllers/puzzle_controller.dart';

void main() {
  testWidgets('rejected placement clears and restart cancels feedback', (
    tester,
  ) async {
    final controller = PuzzleController();
    controller.select(0);
    expect(controller.place(0, 1), isFalse);
    expect(controller.rejectedSlot, 1);
    expect(controller.selected, 0);
    await tester.pump(const Duration(milliseconds: 650));
    expect(controller.rejectedSlot, isNull);
    controller.place(0, 1);
    controller.restart(layout: PuzzleLayout.triangles, dimension: 4);
    expect(controller.game.total, 32);
    expect(controller.rejectedSlot, isNull);
    expect(controller.selected, isNull);
    expect(controller.seconds, 0);
    await tester.pump(const Duration(seconds: 2));
    expect(controller.seconds, 0);
    controller.dispose();
  });

  testWidgets('completion stops the session timer', (tester) async {
    final controller = PuzzleController();
    controller.place(0, 0);
    await tester.pump(const Duration(seconds: 3));
    expect(controller.seconds, 3);
    for (var id = 1; id < controller.game.total; id++) {
      controller.place(id, id);
    }
    await tester.pump(const Duration(seconds: 3));
    expect(controller.seconds, 3);
    expect(controller.game.isComplete, isTrue);
    controller.dispose();
  });
}
