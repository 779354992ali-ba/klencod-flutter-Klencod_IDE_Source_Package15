# Package 11 — SAF file service hardening

This update improves the existing Android Storage Access Framework service
without changing the explorer UI or removing existing features.

## Changes

- Validate child names before create, rename, and lookup operations.
- Reject empty names, path separators, null bytes, and `.` / `..` path segments.
- Trim accidental leading/trailing whitespace from names.
- Infer MIME types for common source, markup, image, and document extensions
  when callers do not explicitly provide one.
- Preserve the generic binary MIME fallback for unknown extensions.
- Add focused unit tests for name validation and MIME inference.

## Validation status

The ZIP archive and source edits can be checked locally, but Flutter tests and
`flutter analyze` were not run in this environment because Flutter/Dart SDKs
are unavailable. Run the commands in the project root on the development
machine before merging or building a release:

```bash
flutter pub get
flutter analyze
flutter test
```
