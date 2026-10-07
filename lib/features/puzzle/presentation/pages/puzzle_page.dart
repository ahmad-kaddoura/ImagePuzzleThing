import 'package:flutter/material.dart';

import '../widgets/image_puzzle.dart';
import '../widgets/image_source_dialog.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({super.key});

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  ImageProvider _image = const AssetImage(
    'assets/images/lakeside_reference.png',
  );

  Future<void> _changeImage() async {
    final image = await showDialog<ImageProvider>(
      context: context,
      builder: (context) => const ImageSourceDialog(),
    );
    if (image != null && mounted) setState(() => _image = image);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: ImagePuzzle(
      image: _image,
      title: _image == const AssetImage('assets/images/lakeside_reference.png')
          ? 'Lakeside daydream'
          : 'Your little escape',
      initialDimension: 5,
      onChangeImage: _changeImage,
    ),
  );
}
