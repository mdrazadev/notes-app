import 'dart:io';

import 'package:notes_app/res/mixins/logger_mixin.dart';

enum DirStatus { created, exists, error }

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
  Future<DirStatus> createDir(String dirName) async {
    try {
      // Public Documents folder (visible to users)
      final Directory dir = Directory(
        '/storage/emulated/0/Documents/NotesApp/$dirName',
      );

      if (!await dir.exists()) {
        await dir.create(recursive: true);
        logDebug("📁 Created folder at: ${dir.path}");
        return DirStatus.created;
      } else {
        logDebug("📂 Folder already exists: ${dir.path}");
        return DirStatus.exists;
      }
    } catch (e) {
      logInfo("Error occured: ${e.toString()}");
      return DirStatus.error;
    }
  }

  /// Method to [Delete] any specific [Directory]
  deleteDir(String dirName) async {
    final Directory dir = Directory(
      '/storage/emulated/0/Documents/NotesApp/$dirName',
    );

    await dir.delete(recursive: true);
  }

  Future<List<Directory>?> listOfDir({String? dirName}) async {
    String folder =
        dirName != null
            ? '/storage/emulated/0/Documents/NotesApp/$dirName'
            : '/storage/emulated/0/Documents/NotesApp';
    final Directory dir = Directory(folder);

    if (await dir.exists()) {
      // List of all entities (files + folders)
      final entities = dir.listSync();

      // Filtering folders only
      final dirs = entities.whereType<Directory>().toList();
      logDebug("${dirs.length} folders found");
      return dirs;
    } else {
      logError("${dirName ?? "NotesApp"} folder not found");
      return null;
    }
  }
}
