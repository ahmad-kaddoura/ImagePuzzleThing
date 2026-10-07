# Image Puzzle

A Flutter image puzzle with three interchangeable layouts: interlocking jigsaw, square mosaic, and triangular prism. Choose a layout or use the random-layout button. Easy, medium, and hard use 3×3, 4×4, and 5×5 cells; prism has two pieces per cell.

Drag a piece into its matching slot, or select a piece and tap a slot. Correct placements animate into place with a bundled snap sound and light haptic feedback. Completion plays a short chime and a stronger haptic. Sound and haptics can be disabled independently.

## Run

```sh
flutter pub get
flutter run
```

## Piece sheet

The app starts with the reference-inspired lakeside screen and a 5×5 jigsaw. Drag the piece-sheet header upward or tap its handle to expand the grid. The grid retains every piece; placed pieces are grayscale and cannot be selected or dragged. Selecting an available piece collapses the sheet and brings that piece to the front of the strip.

Open the settings gear for layouts, difficulty, preview, sound, haptics, restart, and image selection.

## Use your own image

The settings panel’s image button accepts a direct HTTPS image URL or a bundled asset path. The included reference-inspired lakeside artwork works offline. Asset paths must be registered in `pubspec.yaml`.

The reusable widget accepts any Flutter `ImageProvider`:

```dart
ImagePuzzle(
  image: const AssetImage('assets/images/lakeside.png'),
  initialLayout: PuzzleLayout.jigsaw,
  initialDimension: 3,
)
```

```dart
ImagePuzzle(
  image: NetworkImage(imageUrl),
  initialLayout: PuzzleLayout.triangles,
  title: 'Your little escape',
)
```

Import `ImagePuzzle` from `lib/features/puzzle/presentation/widgets/image_puzzle.dart` and `PuzzleLayout` from `lib/features/puzzle/domain/puzzle_layout.dart`. Supported starting difficulties are 3, 4, and 5. All layouts use the same centered square crop. Images are decoded at a bounded resolution, with loading, failure, and retry states.

## Structure

- `lib/app/`: app composition and theme.
- `lib/features/puzzle/domain/`: layout definitions and placement rules, independent of Flutter.
- `lib/features/puzzle/presentation/controllers/`: session state and feedback lifecycle.
- `lib/features/puzzle/presentation/widgets/`: image loading, geometry, painting, board, tray, and responsive controls.
- `lib/features/puzzle/presentation/pages/`: screen composition.

Follow [AGENTS.md](AGENTS.md) for project rules. Generated native files may regain comments during Flutter or CocoaPods builds.

## Validate

```sh
dart format lib test
flutter analyze
flutter test
flutter build ios --simulator --debug
flutter build apk --debug
```

Tests cover placement, invalid and duplicate attempts, completion, shape coverage, drag and tap interaction, preview protection, and phone and landscape layout bounds, sheet expansion by swiping, grid selection, and disabled placed pieces. Physical haptic feel requires a supported device; simulators cannot reproduce it.
