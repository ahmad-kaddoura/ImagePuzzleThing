import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/settings/data/puzzle_image_picker.dart';
import '../features/settings/presentation/controllers/puzzle_settings_controller.dart';

import 'pages/puzzle_page.dart';
import 'app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => ProviderScope(
    overrides: [
      imagePickerGatewayProvider.overrideWith((ref) => PuzzleImagePicker()),
    ],
    child: MaterialApp(
      title: 'Piece by Piece',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const PuzzlePage(),
    ),
  );
}
