import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../controllers/puzzle_controller.dart';
import '../controllers/puzzle_feedback.dart';
import 'layout_selector.dart';
import 'piece_tray.dart';
import 'puzzle_board.dart';
import 'puzzle_progress.dart';
import 'puzzle_toolbar.dart';

class WidePuzzleWorkspace extends StatelessWidget {
  const WidePuzzleWorkspace({
    super.key,
    required this.image,
    required this.title,
    required this.controller,
    required this.feedback,
    required this.onFeedbackChanged,
    required this.onPlace,
  });

  final ui.Image image;
  final String title;
  final PuzzleController controller;
  final PuzzleFeedback feedback;
  final VoidCallback onFeedbackChanged;
  final void Function(int, int) onPlace;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutSelector(controller: controller),
        const SizedBox(height: 24),
        PuzzleToolbar(
          controller: controller,
          feedback: feedback,
          onFeedbackChanged: onFeedbackChanged,
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            final board = Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE7EAE1)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0932493D),
                    blurRadius: 30,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  PuzzleProgress(controller: controller, title: title),
                  const SizedBox(height: 24),
                  PuzzleBoard(
                    image: image,
                    controller: controller,
                    onPlace: onPlace,
                  ),
                  const SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: Text(
                      controller.game.isComplete
                          ? 'Every piece found its place. ✨'
                          : controller.preview
                          ? 'Take a peek. Hide the preview to keep playing.'
                          : 'One piece at a time. You’ve got this.',
                      key: ValueKey((
                        controller.game.isComplete,
                        controller.preview,
                      )),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF74837B),
                      ),
                    ),
                  ),
                ],
              ),
            );
            final tray = PieceTray(image: image, controller: controller);
            if (constraints.maxWidth >= 800) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: board),
                  const SizedBox(width: 24),
                  SizedBox(width: 320, child: tray),
                ],
              );
            }
            return Column(children: [board, const SizedBox(height: 20), tray]);
          },
        ),
        if (controller.game.isComplete)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: FilledButton.icon(
                onPressed: () => controller.restart(),
                icon: const Icon(Icons.replay_rounded),
                label: const Text('Find your flow again'),
              ),
            ),
          ),
      ],
    );
  }
}
