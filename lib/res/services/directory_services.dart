import 'dart:io';

import 'package:notes_app/res/mixins/logger_mixin.dart';

class DirectoryServices with LoggerMixin {
  // Step 1: Create a private named constructor
  DirectoryServices._internal();

  // Step 2: Create a static instance of the class (only one)
  static final DirectoryServices _instance = DirectoryServices._internal();

  // Step 3: Provide a public getter to access the single instance
  factory DirectoryServices() {
    return _instance;
  }

  /// Creates [Directory] in device [Document/NotesApp] directory in file manager.
  ///
  /// It accepts one argument [DirectoryName].
  Future<String> createDir(String dirName) async {
    try {
      // Public Documents folder (visible to users)
      final Directory dir = Directory(
        '/storage/emulated/0/Documents/NotesApp/$dirName',
      );

      if (!await dir.exists()) {
        await dir.create(recursive: true);
        logDebug("📁 Created folder at: ${dir.path}");
        return "Created folder at: ${dir.path}";
      } else {
        logDebug("📂 Folder already exists: ${dir.path}");
        return "Folder already exists: ${dir.path}";
      }
    } catch (e) {
      logInfo("Error occured: ${e.toString()}");
      return "Error occured: ${e.toString()}";
    }
  }

  /// Metho to [Delete] any specific [Directory]
  deleteDir(String dirName) async {
    final Directory dir = Directory(
      '/storage/emulated/0/Documents/NotesApp/$dirName',
    );

    await dir.delete(recursive: true);
  }
}
