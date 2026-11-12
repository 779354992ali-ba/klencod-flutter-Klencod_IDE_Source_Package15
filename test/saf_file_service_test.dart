import 'package:flutter_test/flutter_test.dart';
import 'package:bisho_ide/core/services/saf_file_service.dart';

void main() {
  group('SafFileService', () {
    test('trims a valid child name', () {
      expect(SafFileService.validateChildName('  main.dart  '), 'main.dart');
    });

    test('rejects empty names and path traversal segments', () {
      for (final name in ['', '   ', '.', '..', '../secret', r'folder\file']) {
        expect(() => SafFileService.validateChildName(name),
            throwsArgumentError, reason: 'name: $name');
      }
    });

    test('maps common source extensions to MIME types', () {
      expect(SafFileService.mimeTypeForName('index.HTML'), 'text/html');
      expect(SafFileService.mimeTypeForName('app.dart'), 'text/x-dart');
      expect(SafFileService.mimeTypeForName('data.json'), 'application/json');
      expect(SafFileService.mimeTypeForName('unknown.bin'),
          'application/octet-stream');
    });
  });
}
