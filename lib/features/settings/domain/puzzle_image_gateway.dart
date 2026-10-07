import 'dart:typed_data';

abstract interface class PuzzleImageGateway {
  Future<PickedPuzzleImage?> fromGallery();
  Future<PickedPuzzleImage?> fromCamera();
  Future<PickedPuzzleImage?> recoverLostImage();
}

class PickedPuzzleImage {
  const PickedPuzzleImage({required this.bytes, required this.name});

  final Uint8List bytes;
  final String name;
}

class PuzzleImagePickerException implements Exception {
  const PuzzleImagePickerException(this.message);

  final String message;
}
