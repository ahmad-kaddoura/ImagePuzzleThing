import 'package:flutter/material.dart';

import 'package:image_puzzle/core/models/puzzle_session_settings.dart';
import 'package:image_puzzle/core/domain/puzzle_layout.dart';

import 'settings_choice_card.dart';
import 'settings_section.dart';
import 'settings_options_grid.dart';

class PuzzleDifficultyOptions extends StatelessWidget {
  const PuzzleDifficultyOptions({
    super.key,
    required this.selected,
    required this.layout,
    required this.onSelected,
  });

  final PuzzleDifficulty selected;
  final PuzzleLayout layout;
  final ValueChanged<PuzzleDifficulty> onSelected;

  @override
  Widget build(BuildContext context) => SettingsSection(
    icon: Icons.bar_chart_rounded,
    title: 'Difficulty',
    subtitle: 'Choose how many pieces you want',
    child: SettingsOptionsGrid(
      columns: 4,
      children: [
        for (final difficulty in PuzzleDifficulty.values)
          SettingsChoiceCard(
            title: difficulty.label,
            subtitle: '${difficulty.pieceCountFor(layout)} pieces',
            icon: Icons.extension_rounded,
            selected: selected == difficulty,
            onTap: () => onSelected(difficulty),
          ),
      ],
    ),
  );
}
