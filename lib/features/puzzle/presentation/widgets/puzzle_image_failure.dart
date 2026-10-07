import 'package:flutter/material.dart';

class PuzzleImageFailure extends StatelessWidget {
  const PuzzleImageFailure({super.key, required this.onRetry, this.onSettings});

  final VoidCallback onRetry;
  final Future<void> Function()? onSettings;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.broken_image_outlined, size: 40),
            const SizedBox(height: 16),
            const Text(
              'This image couldn’t be loaded.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: onRetry,
                  child: const Text('Try again'),
                ),
                if (onSettings != null)
                  FilledButton(
                    onPressed: onSettings,
                    child: const Text('Choose another image'),
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
