import 'dart:ui' as ui;

import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

import '../domain/puzzle_image_gateway.dart';

class PuzzleImagePicker implements PuzzleImageGateway {
  PuzzleImagePicker({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  @override
  Future<PickedPuzzleImage?> fromGallery() => _pick(ImageSource.gallery);

  @override
  Future<PickedPuzzleImage?> fromCamera() => _pick(ImageSource.camera);

  @override
  Future<PickedPuzzleImage?> recoverLostImage() async {
    final response = await _picker.retrieveLostData();
    final files = response.files;
    if (files == null || files.isEmpty) {
      if (response.exception case final exception?) {
        throw PuzzleImagePickerException(_message(exception));
      }
      return null;
    }
    return _read(files.first);
  }

  Future<PickedPuzzleImage?> _pick(ImageSource source) async {
    try {
      final file = await _picker.pickImage(
        source: source,
        requestFullMetadata: false,
        imageQuality: 92,
        maxWidth: 2400,
        maxHeight: 2400,
      );
      return file == null ? null : await _read(file);
    } on PlatformException catch (error) {
      throw PuzzleImagePickerException(_message(error));
    }
  }

  Future<PickedPuzzleImage> _read(XFile file) async {
    try {
      final bytes = await file.readAsBytes();
      if (bytes.isEmpty) throw const FormatException();
      final codec = await ui.instantiateImageCodec(
        bytes,
        targetWidth: 1600,
        targetHeight: 1600,
      );
      try {
        final frame = await codec.getNextFrame();
        frame.image.dispose();
      } finally {
        codec.dispose();
      }
      return PickedPuzzleImage(bytes: bytes, name: file.name);
    } on Object {
      throw const PuzzleImagePickerException(
        'This photo could not be opened. Please choose another image.',
      );
    }
  }

  String _message(PlatformException error) => switch (error.code) {
    'camera_access_denied' || 'camera_access_restricted' =>
      'Camera access is off. Allow camera access in Settings to take a photo.',
    'photo_access_denied' || 'photo_access_restricted' =>
      'Photo access is off. Allow photo access in Settings to choose a photo.',
    _ => 'The photo could not be opened. Please try again.',
  };
}
