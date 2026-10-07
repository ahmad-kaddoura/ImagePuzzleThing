import 'package:flutter/material.dart';

class PuzzleHeader extends StatelessWidget {
  const PuzzleHeader({
    super.key,
    required this.onChangeImage,
    this.compact = false,
  });

  final VoidCallback onChangeImage;
  final bool compact;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF24786C),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.extension_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          const Flexible(
            child: Text(
              'piece by piece',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 19,
                letterSpacing: -.5,
              ),
            ),
          ),
          const Spacer(),
          if (compact)
            IconButton.filledTonal(
              onPressed: onChangeImage,
              tooltip: 'Your image',
              icon: const Icon(Icons.add_photo_alternate_outlined),
            )
          else
            OutlinedButton.icon(
              onPressed: onChangeImage,
              icon: const Icon(Icons.add_photo_alternate_outlined, size: 18),
              label: const Text('Your image'),
            ),
        ],
      ),
      if (!compact) ...[
        const SizedBox(height: 38),
        const Text(
          'A little focus.\nA lovely escape.',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.6,
            height: 1.12,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Slow down, find your flow, and bring the picture together.',
          style: TextStyle(color: Color(0xFF74837B), fontSize: 15, height: 1.6),
        ),
      ],
    ],
  );
}
