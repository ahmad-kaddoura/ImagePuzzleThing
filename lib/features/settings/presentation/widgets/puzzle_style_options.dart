import 'package:flutter/material.dart';

import 'package:image_puzzle/core/domain/puzzle_layout.dart';

import 'settings_choice_card.dart';
import 'settings_section.dart';
import 'settings_options_grid.dart';

class PuzzleStyleOptions extends StatelessWidget {
  const PuzzleStyleOptions({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final PuzzleLayout selected;
  final ValueChanged<PuzzleLayout> onSelected;

  @override
  Widget build(BuildContext context) => SettingsSection(
    icon: Icons.extension_rounded,
    title: 'Piece Style',
    subtitle: 'Choose the shape style of your pieces',
    child: SettingsOptionsGrid(
      columns: 3,
      children: [
        for (final layout in PuzzleLayout.values)
          SettingsChoiceCard(
            title: layout.label,
            subtitle: layout == PuzzleLayout.jigsaw
                ? 'Classic'
                : layout == PuzzleLayout.mosaic
                ? 'Square'
                : 'Angles',
            icon: switch (layout) {
              PuzzleLayout.jigsaw => Icons.extension_rounded,
              PuzzleLayout.mosaic => Icons.grid_view_rounded,
              PuzzleLayout.triangles => Icons.change_history_rounded,
            },
            selected: selected == layout,
            onTap: () => onSelected(layout),
          ),
      ],
    ),
  );
}
