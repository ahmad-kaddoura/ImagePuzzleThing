import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class PuzzleBackdrop extends StatelessWidget {
  const PuzzleBackdrop({super.key, required this.image});

  final ui.Image image;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      return Stack(
        fit: StackFit.expand,
        children: [
          const ColoredBox(color: Color(0xFFF5F4F0)),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: constraints.maxHeight * .46,
            child: ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.white, Colors.transparent],
                stops: [0, .7, 1],
              ).createShader(bounds),
              child: RawImage(
                image: image,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: constraints.maxHeight * .23,
            child: const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x88EEF5F6), Color(0x00EEF5F6)],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
