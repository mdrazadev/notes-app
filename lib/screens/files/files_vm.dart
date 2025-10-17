// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/res/extensions/color_extsion.dart';
import 'package:notes_app/res/mixins/logger_mixin.dart';
import 'package:notes_app/res/services/file_services.dart';
import 'package:notes_app/res/utils/snackbar_utils.dart';
import 'package:notes_app/screens/home/widgets/add_folder_widget.dart'
    show AddFolderWidget;

class FilesVM extends GetxController with LoggerMixin {
  final RxBool isLoading = false.obs;
  final RxBool isListView = true.obs;
  late final String parentDirName = Get.arguments;
  final TextEditingController controller = TextEditingController();

  List<FileSystemEntity> filesList = [];

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

  void addFileDialog(BuildContext context) {
    final theme = Theme.of(context);
    showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      barrierColor: theme.colorScheme.blacktheme.withValues(alpha: 0.5),
      pageBuilder:
          (context, animation, secondaryAnimation) => SizedBox.shrink(),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: animation.value,
          child: Opacity(
            opacity: animation.value,
            child: AddFolderWidget(
              hintText: "Enter file name",
              controller: controller,
              onFolderAdd: () => createFile(context),
            ),
          ),
        );
      },
    );
  }

  createFile(BuildContext context) async {
    isLoading.value = true;
    final FileServices fileServices = FileServices();

    fileServices.createFile(fileName: controller.text.trim(), dir: parentDirName).then((
      response,
    ) {
      if (response) {
        loadFilesInDir();
        isLoading.value = false;
        SnackbarUtils.bottomSnackbar(context, "File created succesfully");
      } else {
        logDebug("File isn't created");
        isLoading.value = false;
        SnackbarUtils.bottomSnackbar(context, "Something went wrong");
      }
    });
  }
}
