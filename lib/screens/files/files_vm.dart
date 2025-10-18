// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/res/mixins/logger_mixin.dart';
import 'package:notes_app/res/routes/routes_name.dart' show RoutesName;
import 'package:notes_app/res/services/file_services.dart';
import 'package:notes_app/res/utils/snackbar_utils.dart';

class FilesVM extends GetxController with LoggerMixin {
  final RxBool isLoading = false.obs;
  final RxBool isListView = true.obs;
  late final String parentDirName = Get.arguments;
  final TextEditingController headingController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final FocusNode contentFocusnode = FocusNode();

  List<FileSystemEntity> filesList = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    loadFilesInDir();
  }

  loadFilesInDir() async {
    isLoading.value = true;
    final FileServices fileServices = FileServices();

    fileServices
        .getFiles(parentDirName)
        .then((response) {
          filesList = response;
          logDebug("${filesList.length} files found");
          isLoading.value = false;
        })
        .onError((error, stackTrace) {
          isLoading.value = false;
          logDebug(error.toString());
        });
  }

  createFile(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      final FileServices fileServices = FileServices();
      final String fileName = headingController.text.trim();

      fileServices.createFile(fileName: fileName, dir: parentDirName).then((
        response,
      ) {
        if (response) {
          loadFilesInDir();
          addContentToFile(context);
          isLoading.value = false;
        } else {
          logDebug("File isn't created");
          isLoading.value = false;
          SnackbarUtils.bottomSnackbar(context, "Something went wrong");
        }
      });
    }
  }

  addContentToFile(BuildContext context) async {
    isLoading.value = true;
    final String heading = headingController.text.trim();
    final String content = contentController.text;

    final FileServices fileServices = FileServices();

    fileServices
        .addContentToFile(
          filePath: "/storage/emulated/0/Documents/NotesApp/$heading.txt",
          content: "$heading\n\n\n$content",
        )
        .then((_) {
          contentFocusnode.unfocus();
          isLoading.value = false;
        })
        .onError((error, stackTrace) {
          logDebug(error.toString());
          isLoading.value = false;
          SnackbarUtils.bottomSnackbar(context, "Something went wrong");
        });
  }

  openNotepad() {
    Get.toNamed(RoutesName.notepad)?.then((result) {
      loadFilesInDir();
    });
  }
}
