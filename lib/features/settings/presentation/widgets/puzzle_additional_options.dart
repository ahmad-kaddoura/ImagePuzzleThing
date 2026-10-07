import 'package:flutter/material.dart';

import 'settings_section.dart';
import 'settings_toggle_row.dart';

class PuzzleAdditionalOptions extends StatelessWidget {
  const PuzzleAdditionalOptions({
    super.key,
    required this.preview,
    required this.snap,
    required this.highlights,
    required this.onPreviewChanged,
    required this.onSnapChanged,
    required this.onHighlightsChanged,
  });

  final bool preview;
  final bool snap;
  final bool highlights;
  final ValueChanged<bool> onPreviewChanged;
  final ValueChanged<bool> onSnapChanged;
  final ValueChanged<bool> onHighlightsChanged;

  @override
  Widget build(BuildContext context) => SettingsSection(
    icon: Icons.settings_outlined,
    title: 'Additional Options',
    child: Column(
      children: [
        SettingsToggleRow(
          icon: Icons.visibility_outlined,
          title: 'Show piece preview',
          subtitle: 'Show a preview when selecting a piece',
          value: preview,
          onChanged: onPreviewChanged,
        ),
        const Divider(height: 1, indent: 48),
        SettingsToggleRow(
          icon: Icons.crop_free_rounded,
          title: 'Snap to position',
          subtitle: 'Automatically snap pieces when close',
          value: snap,
          onChanged: onSnapChanged,
        ),
        const Divider(height: 1, indent: 48),
        SettingsToggleRow(
          icon: Icons.center_focus_strong_rounded,
          title: 'Highlight matching areas',
          subtitle: 'Show hints for possible positions',
          value: highlights,
          onChanged: onHighlightsChanged,
        ),
      ],
    ),
  );
}
