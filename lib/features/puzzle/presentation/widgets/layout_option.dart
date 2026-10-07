import 'package:flutter/material.dart';

import '../../domain/puzzle_layout.dart';

class LayoutOption extends StatelessWidget {
  const LayoutOption({
    super.key,
    required this.layout,
    required this.selected,
    required this.onTap,
  });

  final PuzzleLayout layout;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    selected: selected,
    child: Material(
      color: selected ? const Color(0xFFE0EBE2) : Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: selected
                  ? const Color(0xFF24786C)
                  : const Color(0xFFE6E9E1),
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              Icon(
                switch (layout) {
                  PuzzleLayout.jigsaw => Icons.extension_outlined,
                  PuzzleLayout.mosaic => Icons.grid_view_rounded,
                  PuzzleLayout.triangles => Icons.change_history_rounded,
                },
                color: const Color(0xFF24786C),
                size: 28,
              ),
              const SizedBox(height: 10),
              Text(
                layout.label,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
