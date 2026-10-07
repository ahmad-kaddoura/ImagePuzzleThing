import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_puzzle/core/domain/puzzle_layout.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/piece_painter.dart';
import 'package:image_puzzle/features/puzzle/presentation/widgets/piece_path.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  for (final layout in PuzzleLayout.values) {
    test('${layout.label} pieces reconstruct the same image crop', () async {
      const dimension = 5;
      const cell = 40.0;
      final sourceRecorder = ui.PictureRecorder();
      final sourceCanvas = Canvas(sourceRecorder);
      for (var row = 0; row < dimension; row++) {
        for (var col = 0; col < dimension; col++) {
          sourceCanvas.drawRect(
            Rect.fromLTWH(40 + col * cell, row * cell, cell, cell),
            Paint()
              ..color = Color.fromARGB(255, 20 + row * 40, 20 + col * 40, 100),
          );
        }
      }
      final sourcePicture = sourceRecorder.endRecording();
      final source = await sourcePicture.toImage(280, 200);
      sourcePicture.dispose();
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      for (var id = 0; id < layout.pieceCount(dimension); id++) {
        final index = layout.cellIndex(id);
        canvas.save();
        canvas.translate(
          (index % dimension) * cell - cell * PiecePath.padding,
          (index ~/ dimension) * cell - cell * PiecePath.padding,
        );
        PiecePainter(
          image: source,
          id: id,
          dimension: dimension,
          layout: layout,
          cell: cell,
          ghost: false,
          revealGhost: false,
        ).paint(canvas, const Size.square(cell * 1.44));
        canvas.restore();
      }
      final picture = recorder.endRecording();
      final assembled = await picture.toImage(200, 200);
      picture.dispose();
      final bytes = (await assembled.toByteData(
        format: ui.ImageByteFormat.rawRgba,
      ))!;
      for (var row = 0; row < dimension; row++) {
        for (var col = 0; col < dimension; col++) {
          final offset = ((row * 40 + 12) * 200 + col * 40 + 12) * 4;
          expect(bytes.getUint8(offset), 20 + row * 40);
          expect(bytes.getUint8(offset + 1), 20 + col * 40);
          expect(bytes.getUint8(offset + 2), 100);
          expect(bytes.getUint8(offset + 3), 255);
        }
      }
      assembled.dispose();
      source.dispose();
    });
  }
}
