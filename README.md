# Image Puzzle

A minimal Flutter application with a blank starting page.

## Run

```sh
flutter pub get
flutter run
```

## Structure

```text
lib/
  main.dart
  app/
    app.dart
  features/
    puzzle/
      presentation/
        pages/
          puzzle_page.dart
```

Add feature widgets under `presentation/widgets/` and introduce domain and data layers as needed. Follow the project rules in [AGENTS.md](AGENTS.md).

## Validate

```sh
dart format lib
flutter analyze
```
