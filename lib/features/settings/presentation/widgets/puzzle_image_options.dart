import 'package:flutter/material.dart';
import 'package:image_puzzle/core/models/puzzle_session_settings.dart';

import 'settings_image_card.dart';
import 'settings_section.dart';
import 'settings_camera_card.dart';
import 'settings_options_grid.dart';

class PuzzleImageOptions extends StatelessWidget {
  const PuzzleImageOptions({
    super.key,
    required this.image,
    required this.sampleImage,
    required this.source,
    required this.busy,
    required this.onGallery,
    required this.onSample,
    required this.onCamera,
  });

  final ImageProvider image;
  final ImageProvider sampleImage;
  final PuzzleImageSource source;
  final bool busy;
  final VoidCallback onGallery;
  final VoidCallback onSample;
  final VoidCallback onCamera;

  @override
  Widget build(BuildContext context) => SettingsSection(
    icon: Icons.add_photo_alternate_outlined,
    title: 'Puzzle Image',
    subtitle: 'Choose a photo to turn into a puzzle',
    child: SettingsOptionsGrid(
      columns: 3,
      minimumWidth: 90,
      children: [
        SizedBox(
          height: 100 + MediaQuery.textScalerOf(context).scale(12),
          child: SettingsImageCard(
            label: 'Choose from gallery',
            image: image,
            selected: source == PuzzleImageSource.gallery,
            onTap: busy ? null : onGallery,
          ),
        ),
        SizedBox(
          height: 100 + MediaQuery.textScalerOf(context).scale(12),
          child: SettingsImageCard(
            label: 'Use sample images',
            image: sampleImage,
            selected: source == PuzzleImageSource.sample,
            onTap: busy ? null : onSample,
          ),
        ),
        SizedBox(
          height: 100 + MediaQuery.textScalerOf(context).scale(12),
          child: SettingsCameraCard(
            busy: busy,
            selected: source == PuzzleImageSource.camera,
            onTap: onCamera,
          ),
        ),
      ],
    ),
  );
}
