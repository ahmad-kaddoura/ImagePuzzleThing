import 'package:flutter/material.dart';

import 'package:image_puzzle/core/domain/puzzle_layout.dart';

import 'puzzle_workspace.dart';
import 'puzzle_image_failure.dart';

class ImagePuzzle extends StatefulWidget {
  const ImagePuzzle({
    super.key,
    required this.image,
    this.title = 'Your little escape',
    this.initialLayout = PuzzleLayout.jigsaw,
    this.initialDimension = 3,
    this.onSettings,
    this.snapToPosition = true,
    this.showPiecePreview = true,
    this.highlightMatchingAreas = true,
    this.soundEnabled = true,
    this.hapticsEnabled = true,
  });

  final ImageProvider image;
  final String title;
  final PuzzleLayout initialLayout;
  final int initialDimension;
  final Future<void> Function()? onSettings;
  final bool snapToPosition;
  final bool showPiecePreview;
  final bool highlightMatchingAreas;
  final bool soundEnabled;
  final bool hapticsEnabled;

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
      return PuzzleImageFailure(
        onRetry: () => setState(_resolve),
        onSettings: widget.onSettings,
      );
    }
    final info = _info;
    if (info == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return PuzzleWorkspace(
      key: ObjectKey(widget.image),
      image: info.image,
      title: widget.title,
      initialLayout: widget.initialLayout,
      initialDimension: widget.initialDimension,
      onSettings: widget.onSettings,
      snapToPosition: widget.snapToPosition,
      showPiecePreview: widget.showPiecePreview,
      highlightMatchingAreas: widget.highlightMatchingAreas,
      soundEnabled: widget.soundEnabled,
      hapticsEnabled: widget.hapticsEnabled,
    );
  }
}
