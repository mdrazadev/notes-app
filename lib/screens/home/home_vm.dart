// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/res/extensions/color_extsion.dart';
import 'package:notes_app/res/mixins/logger_mixin.dart';
import 'package:notes_app/res/services/directory_services.dart';
import 'package:notes_app/res/utils/snackbar_utils.dart';
import 'package:notes_app/screens/home/widgets/add_folder_widget.dart'
    show AddFolderWidget;
import 'package:permission_handler/permission_handler.dart';

class HomeVM extends GetxController with LoggerMixin {
  RxBool isLoading = false.obs;

  final TextEditingController controller = TextEditingController();

  RxList<String> foldersList =
      <String>[
        // "Begin",
        // "Ideas",
        // "Inspiration",
        // "Projects",
        // "Self care",
        // "Travel ideas",
      ].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.context != null) {
      getListOfFolders(Get.context!);
    }
  }

  void addFolderDialog(BuildContext context) {
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
              controller: controller,
              onFolderAdd: () => addFolder(context),
            ),
          ),
        );
      },
    );
  }

  addFolder(BuildContext context) async {
    isLoading.value = true;
    final bool isGranted = await requestPermission();

    if (isGranted) {
      final DirectoryServices dirServices = DirectoryServices();

      dirServices.createDir(controller.text.trim()).then((respones) {
        controller.clear();
        getListOfFolders(context);
        Get.back();
        isLoading.value = false;
        if (respones == DirStatus.created) {
          SnackbarUtils.bottomSnackbar(context, "Folder created successfully.");
        } else if (respones == DirStatus.exists) {
          SnackbarUtils.bottomSnackbar(context, "Folder already exists.");
        } else {
          SnackbarUtils.bottomSnackbar(
            context,
            "Something went wrong.",
            isDangerous: true,
          );
        }
      });
      isLoading.value = false;
    } else {
      logDebug("Storage permission is not granted");
      isLoading.value = false;
      SnackbarUtils.bottomSnackbar(
        context,
        "Storage permission is not granted",
      );
    }
  }

  Future<bool> requestPermission() async {
    if (await Permission.manageExternalStorage.isGranted) {
      logDebug("✅ Permission already granted");
      return true;
    }

    var status = await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      logDebug("✅ Storage permission granted");
      return true;
    } else {
      logDebug("❌ Storage permission denied");
      return false;
    }
  }

  Future<void> getListOfFolders(BuildContext context) async {
    isLoading.value = true;
    final DirectoryServices directoryServices = DirectoryServices();

    directoryServices.listOfDir().then((response) {
      if (response != null) {
        foldersList.value =
            response.map((dir) => dir.path.split("/").last).toList();
        isLoading.value = false;
        SnackbarUtils.bottomSnackbar(
          context,
          "${response.length} folders found",
        );
      } else {
        isLoading.value = false;
        SnackbarUtils.bottomSnackbar(
          context,
          "No folders found",
          isDangerous: true,
        );
      }
    });
  }
}
