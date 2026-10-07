import 'package:flutter/material.dart';

import '../features/puzzle/presentation/pages/puzzle_page.dart';
import 'app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Piece by Piece',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    home: const PuzzlePage(),
  );
}
