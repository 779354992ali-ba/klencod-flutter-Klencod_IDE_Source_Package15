# Package 12 — Completion Relevance

## Changes

- Contextual completion candidates are now ranked before generic language keywords when candidates have the same match score.
- This makes file-specific snippets and project identifiers more useful in the completion dialog. For example, `console.log()` is suggested before the generic `const` keyword for the prefix `con` when both are equally relevant.
- Added a regression test covering this ordering.

## Compatibility

- No public API changed.
- No editor UI or existing feature was removed.
- The existing prefix, word-boundary, substring, and subsequence scoring rules are unchanged.

## Validation

The ZIP archive is checked after packaging. Flutter/Dart analysis and tests still need to be run in the project's Flutter environment.
