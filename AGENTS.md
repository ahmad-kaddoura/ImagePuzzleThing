# Project rules

All code must be optimal, scalable, maintainable, and easy to read.

## Architecture

- Use feature-first architecture: keep each feature under `lib/features/<feature_name>/`.
- Organize feature code into `presentation`, `domain`, and `data` layers as needed. Create layers only when they have real responsibilities.
- Keep app composition, routing, and app-wide configuration under `lib/app/`.
- Put genuinely shared widgets and infrastructure under `lib/core/` only when multiple features need them.
- Keep business logic out of widgets. Keep domain code independent of Flutter, platform APIs, and data implementations.
- Access external services through clear interfaces, and inject dependencies explicitly.
- Avoid direct dependencies between feature implementations. Share contracts or compose features at the app level.

## Widgets and files

- Divide UI into small, focused widget classes, with each widget in its own file.
- Keep pages responsible for composing widgets rather than implementing every UI detail.
- Place feature-specific widgets under that feature's `presentation/widgets/` directory.
- Prefer widget classes over methods that return widgets.
- Keep files focused on one responsibility and typically under 150 lines. Split larger files at meaningful responsibility boundaries.
- Use descriptive names, `snake_case` filenames, and readable, shallow widget trees.
- Extract repeated or independently meaningful UI into widgets; avoid unnecessary wrappers and empty abstractions.

## Quality and performance

- Use the simplest correct implementation and introduce abstractions only when they solve an existing need.
- Prefer immutable models, `final` fields, and `const` constructors and widgets where possible.
- Keep state local to the smallest relevant scope and limit rebuilds to affected widgets.
- Avoid expensive work and side effects in `build`; use lazy builders for large collections and dispose owned resources.
- Handle loading, empty, success, and failure states explicitly when applicable.
- Avoid speculative optimization. Measure performance when a bottleneck is suspected.
- Keep dependencies minimal and avoid introducing competing approaches to the same concern.
- Add meaningful tests for business logic and nontrivial behavior as features are implemented.
- Run `dart format lib` and `flutter analyze` after code changes, plus relevant tests when present.

## Clean code

- Do not add source-code comments, commented-out code, demo screens, sample counter code, or placeholder tests.
- Express intent through clear names and small units of code. Keep project guidance in Markdown documentation.
- Retain platform bootstrap code and build configuration needed to run the app.
- Flutter may regenerate tool-owned files with comments; do not modify SDK or dependency sources to remove them.
