import 'package:flutter/material.dart';

class PuzzleSettingsHeader extends StatelessWidget {
  const PuzzleSettingsHeader({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(18, 8, 18, 4),
    child: Row(
      children: [
        IconButton.filledTonal(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF153D3B),
          ),
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Puzzle Settings',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF143D3B),
                ),
              ),
              Text(
                'Customize your puzzle experience',
                style: TextStyle(fontSize: 12, color: Color(0xFF718389)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
