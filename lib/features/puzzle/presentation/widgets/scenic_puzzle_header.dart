import 'package:flutter/material.dart';

class ScenicPuzzleHeader extends StatelessWidget {
  const ScenicPuzzleHeader({
    super.key,
    required this.title,
    required this.onSettings,
  });

  final String title;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2C8C80), Color(0xFF165A50)],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x20246154),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.extension_rounded,
          color: Colors.white,
          size: 29,
        ),
      ),
      const SizedBox(width: 14),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'piece by piece',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
                letterSpacing: -.7,
                color: Color(0xFF0F3338),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF72838A),
                letterSpacing: .2,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(width: 10),
      IconButton.filled(
        onPressed: onSettings,
        tooltip: 'Puzzle settings',
        style: IconButton.styleFrom(
          backgroundColor: const Color(0xEFFFFFFF),
          foregroundColor: const Color(0xFF102C31),
          fixedSize: const Size(46, 46),
        ),
        icon: const Icon(Icons.settings_outlined, size: 24),
      ),
    ],
  );
}
