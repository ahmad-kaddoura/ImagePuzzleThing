import 'package:flutter/material.dart';

import '../../domain/puzzle_layout.dart';
import 'puzzle_workspace.dart';

class ImagePuzzle extends StatefulWidget {
  const ImagePuzzle({
    super.key,
    required this.image,
    this.title = 'Your little escape',
    this.initialLayout = PuzzleLayout.jigsaw,
    this.initialDimension = 3,
    this.onChangeImage,
  });

  final ImageProvider image;
  final String title;
  final PuzzleLayout initialLayout;
  final int initialDimension;
  final VoidCallback? onChangeImage;

  @override
  State<ImagePuzzle> createState() => _ImagePuzzleState();
}

class _ImagePuzzleState extends State<ImagePuzzle> {
  ImageStream? _stream;
  ImageStreamListener? _listener;
  ImageInfo? _info;
  bool _failed = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_stream == null) _resolve();
  }

  @override
  void didUpdateWidget(ImagePuzzle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.image != widget.image) _resolve();
  }

  void _resolve() {
    _detach();
    _info?.dispose();
    _info = null;
    _failed = false;
    _stream = ResizeImage(
      widget.image,
      width: 1600,
      height: 1600,
      policy: ResizeImagePolicy.fit,
    ).resolve(createLocalImageConfiguration(context));
    _listener = ImageStreamListener(
      (info, synchronous) {
        if (!mounted) {
          info.dispose();
          return;
        }
        setState(() {
          _info?.dispose();
          _info = info;
        });
      },
      onError: (Object error, StackTrace? stackTrace) {
        if (mounted) setState(() => _failed = true);
      },
    );
    _stream!.addListener(_listener!);
  }

  void _detach() {
    if (_listener != null) _stream?.removeListener(_listener!);
  }

  @override
  void dispose() {
    _detach();
    _info?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Icon(Icons.broken_image_outlined, size: 40),
            const SizedBox(height: 16),
            const Text('This image couldn’t be loaded. Check its path or URL.'),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => setState(_resolve),
              child: const Text('Try again'),
            ),
          ],
        ),
      );
    }
    final info = _info;
    if (info == null) {
      return const SizedBox(
        height: 320,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return PuzzleWorkspace(
      key: ObjectKey(widget.image),
      image: info.image,
      title: widget.title,
      initialLayout: widget.initialLayout,
      initialDimension: widget.initialDimension,
      onChangeImage: widget.onChangeImage,
    );
  }
}
