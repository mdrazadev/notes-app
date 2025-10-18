import 'dart:io';

import 'package:notes_app/res/mixins/logger_mixin.dart';

class FileServices with LoggerMixin {
  // Step 1: Create a private named constructor
  FileServices._internal();

  // Step 2: Create a static instance of the class (only one)
  static final FileServices _instance = FileServices._internal();

  // Step 3: Provide a public getter to access the single instance
  factory FileServices() {
    return _instance;
  }

  /// Creates a [TextFile] at give path.
  Future<bool> createFile({
    required String fileName,
    required String dir,
  }) async {
    try {
      // Ensure directory exists
      final directory = Directory(
        "/storage/emulated/0/Documents/NotesApp/$dir",
      );
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      // Create the file
      final file = File("${directory.path}/$fileName.txt");
      if (!await file.exists()) {
        await file.create();
      }

      logDebug("✅ File created at: ${file.path}");
      return true;
    } catch (e) {
      logError("❌ Error creating file: $e");
      return false;
    }
  }

  Future<void> addContentToFile({
    required String filePath,
    required String content,
  }) async {
    final File file = File(filePath);

    if (await file.exists()) {
      await file.writeAsString(content);
    }
  }

  /// Returns [ListOfFiles] in given [Directory]
  Future<List<FileSystemEntity>> getFiles(String dirName) async {
    // Public Documents folder (visible to users)
    final Directory dir = Directory(
      '/storage/emulated/0/Documents/NotesApp/$dirName',
    );
    final List<FileSystemEntity> files = dir.listSync();

    for (final FileSystemEntity file in files) {
      final FileStat fileStat = await file.stat();

      logDebug("Path: ${file.path}");
      logDebug("Type: ${fileStat.type}");
      logDebug("Changed: ${fileStat.changed}");
      logDebug("Modified: ${fileStat.modified}");
      logDebug("Accessed: ${fileStat.accessed}");
      logDebug("Mode: ${fileStat.mode}");
      logDebug("Size: ${fileStat.size}");
    }

    return files;
  }

  Future<String> readFile({
    required String fileName,
    required String dirName,
  }) async {
    // Public Documents folder (visible to users)
    final Directory dir = Directory(
      '/storage/emulated/0/Documents/NotesApp/$dirName',
    );
    final File file = File("${dir.path}/$fileName.txt");

    final String fileContent = await file.readAsString();

    return fileContent;
  }

  /// Returns [Path] of [CopyFile]
  Future<String> copyFile({
    required String fileName,
    required String dirName,
  }) async {
    // Public Documents folder (visible to users)
    final Directory dir = Directory(
      '/storage/emulated/0/Documents/NotesApp/$dirName',
    );
    final File file = File("${dir.path}/$fileName.txt");

    final File copyFile = await file.copy("${dir.path}/copy_of_$fileName.txt");

    return copyFile.path;
  }

  /// Method to [Rename] a file.
  renameFile({
    required String fileName,
    required String newFileName,
    required String dirName,
  }) async {
    // Public Documents folder (visible to users)
    final Directory dir = Directory(
      '/storage/emulated/0/Documents/NotesApp/$dirName',
    );
    final File file = File("${dir.path}/$fileName.txt");

    await file.rename("${dir.path}/$newFileName.txt");
  }
}
