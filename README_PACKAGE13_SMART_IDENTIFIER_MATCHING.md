# Package 13 – Smart Identifier Matching

## What changed

- Improved lexical completion ranking with abbreviation matching for camelCase and snake_case identifiers.
- Examples: `cl` can match `createLayout`, and `lf` can match `load_file`.
- Kept direct prefix and word-boundary matches ahead of abbreviation and general subsequence matches.
- Added tests covering camelCase and snake_case matching.

## Scope and compatibility

This remains lightweight lexical completion. It does not claim semantic type inference or language-server functionality. Existing callers and method signatures are unchanged.

## Validation

The source and test changes were reviewed, and the ZIP archive was integrity-checked. Flutter/Dart analysis and tests were not run in this environment; run `flutter analyze` and `flutter test` before using this package for a release build.
