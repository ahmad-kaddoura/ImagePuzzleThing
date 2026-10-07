import 'package:flutter/material.dart';

import '../widgets/image_puzzle.dart';
import '../widgets/image_source_dialog.dart';
import '../widgets/puzzle_header.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({super.key});

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  ImageProvider _image = const AssetImage('assets/images/lakeside.png');

  Future<void> _changeImage() async {
    final image = await showDialog<ImageProvider>(
      context: context,
      builder: (context) => const ImageSourceDialog(),
    );
    if (image != null && mounted) setState(() => _image = image);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final puzzle = ImagePuzzle(
            image: _image,
            title: _image == const AssetImage('assets/images/lakeside.png')
                ? 'Lakeside daydream'
                : 'Your little escape',
          );
          if (constraints.maxWidth < 600 &&
              constraints.maxHeight >= 620 &&
              MediaQuery.textScalerOf(context).scale(14) <= 18.2) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Column(
                children: [
                  PuzzleHeader(onChangeImage: _changeImage, compact: true),
                  const SizedBox(height: 16),
                  Expanded(child: puzzle),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1040),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PuzzleHeader(
                      onChangeImage: _changeImage,
                      compact: constraints.maxWidth < 600,
                    ),
                    const SizedBox(height: 30),
                    puzzle,
                    const SizedBox(height: 32),
                    const Center(
                      child: Text(
                        'A small pause for a curious mind.',
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: .5,
                          color: Color(0xFF88938A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
