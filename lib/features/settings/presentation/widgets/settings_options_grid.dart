import 'package:flutter/material.dart';

class SettingsOptionsGrid extends StatelessWidget {
  const SettingsOptionsGrid({
    super.key,
    required this.children,
    required this.columns,
    this.minimumWidth = 75,
  });
  final List<Widget> children;
  final int columns;
  final double minimumWidth;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final scale = MediaQuery.textScalerOf(context).scale(14) / 14;
      final available =
          ((constraints.maxWidth + 8) / (minimumWidth * scale + 8))
              .floor()
              .clamp(1, columns);
      final count = columns == 4 && available == 3 ? 2 : available;
      final width = (constraints.maxWidth - (count - 1) * 8) / count;
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final child in children) SizedBox(width: width, child: child),
        ],
      );
    },
  );
}
