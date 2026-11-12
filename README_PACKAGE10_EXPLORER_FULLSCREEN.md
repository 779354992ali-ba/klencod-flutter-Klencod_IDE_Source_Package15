# Package 10 — File Explorer Drawer & Full-screen Editor

- Moved the project file explorer from the editor's side-by-side layout into a slide-out navigation drawer.
- Widened the explorer to make folder and file names easier to read.
- Kept the recursive folder tree, file opening, create file/folder, refresh, rename, delete, and working-directory actions.
- Selecting a project file opens it in the editor and closes the drawer.
- Added an editor full-screen action in the app bar. Full-screen mode hides the IDE toolbars, tabs, and status panel so the code editor uses the available screen area.
- Added a compact full-screen header with the current filename, save action, and a return-to-IDE control.
- The existing editor state and open tabs remain in the same screen state when switching modes.

Build validation: not run in this environment because Flutter/Dart SDK is not installed here. Run `flutter analyze` and `flutter build apk --release` in the project environment.
