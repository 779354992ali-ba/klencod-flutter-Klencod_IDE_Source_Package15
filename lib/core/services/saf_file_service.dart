
import 'dart:typed_data';

import 'package:saf/saf.dart';

class SafFileService {
  final Saf _saf = Saf();

  /// Validates a single Storage Access Framework child name.
  ///
  /// SAF accepts provider-specific names, but a path separator or a dot
  /// segment must never be treated as a child name by this service.
  static String validateChildName(String value) {
    final name = value.trim();
    if (name.isEmpty) {
      throw ArgumentError.value(value, 'name', 'اسم الملف أو المجلد مطلوب.');
    }
    if (name == '.' || name == '..' ||
        name.contains('/') || name.contains('\\') ||
        name.contains('\u0000')) {
      throw ArgumentError.value(
        value,
        'name',
        'استخدم اسمًا واحدًا دون مسارات أو مقاطع نسبية.',
      );
    }
    return name;
  }

  /// Returns a useful MIME type for common source and document files.
  /// Unknown extensions intentionally fall back to binary data.
  static String mimeTypeForName(String fileName) {
    final normalized = fileName.toLowerCase();
    final dot = normalized.lastIndexOf('.');
    final extension = dot < 0 ? '' : normalized.substring(dot + 1);
    const types = <String, String>{
      'html': 'text/html', 'htm': 'text/html',
      'css': 'text/css', 'js': 'text/javascript',
      'mjs': 'text/javascript', 'json': 'application/json',
      'xml': 'application/xml', 'svg': 'image/svg+xml',
      'md': 'text/markdown', 'txt': 'text/plain',
      'dart': 'text/x-dart', 'py': 'text/x-python',
      'java': 'text/x-java-source', 'kt': 'text/x-kotlin',
      'yaml': 'application/yaml', 'yml': 'application/yaml',
      'pdf': 'application/pdf', 'png': 'image/png',
      'jpg': 'image/jpeg', 'jpeg': 'image/jpeg',
    };
    return types[extension] ?? 'application/octet-stream';
  }

  // اختيار مجلد المشروع
  Future<SafDocumentFile?> pickProjectFolder() async {
    return _saf.pickDirectory(
      writePermission: true,
      persistablePermission: true,
    );
  }

  // اختيار ملف
  Future<SafDocumentFile?> pickFile() async {
    return _saf.pickFile(
      persistablePermission: true,
    );
  }

  // استرجاع جميع صلاحيات SAF المحفوظة
  Future<List<SafPersistedPermission>>
      getPersistedPermissions() async {
    return _saf.persistedPermissions();
  }

  // عرض محتويات مجلد
  Future<List<SafDocumentFile>> listDirectory(
    String directoryUri,
  ) async {
    return _saf.list(directoryUri);
  }

  // قراءة ملف
  Future<Uint8List> readFile(String fileUri) async {
    return _saf.readFileBytes(fileUri);
  }

  // حفظ ملف
  Future<SafDocumentFile> saveFile({
    required String parentUri,
    required String fileName,
    required Uint8List bytes,
    String? mimeType,
    bool overwrite = true,
  }) async {
    final safeName = validateChildName(fileName);
    return _saf.writeFileBytes(
      parentUri,
      safeName,
      mimeType ?? mimeTypeForName(safeName),
      bytes,
      overwrite: overwrite,
    );
  }

  // إنشاء مجلد
  Future<SafDocumentFile> createFolder({
    required String parentUri,
    required String folderName,
  }) async {
    return _saf.mkdirp(
      parentUri,
      [validateChildName(folderName)],
    );
  }

  // حذف ملف أو مجلد
  Future<void> deleteItem(String uri) async {
    await _saf.delete(uri);
  }

  // إعادة تسمية
  Future<SafDocumentFile> renameItem({
    required String uri,
    required String newName,
  }) async {
    return _saf.rename(uri, validateChildName(newName));
  }

  // البحث عن عنصر داخل مجلد
  Future<SafDocumentFile?> findChild({
    required String parentUri,
    required String name,
  }) async {
    return _saf.child(
      parentUri,
      [validateChildName(name)],
    );
  }

  // الحصول على معلومات ملف أو مجلد
  Future<SafDocumentFile?> getItem(String uri) async {
    return _saf.stat(uri);
  }
}