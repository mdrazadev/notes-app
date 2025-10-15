// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/res/extensions/color_extsion.dart';
import 'package:notes_app/res/mixins/logger_mixin.dart';
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
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
    });
  }

  void addNewFolder(BuildContext context) {
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
              onFolderAdd: () async {
                isLoading.value = true;
                foldersList.insert(0, controller.text);
                requestPermission();
                // final path = await createDir(controller.text.trim());
                // createFileAndAddContent(path);
                controller.clear();
                Get.back();
                isLoading.value = false;
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> requestPermission() async {
    if (await Permission.manageExternalStorage.isGranted) {
      logDebug("✅ Permission already granted");
      return;
    }

    var status = await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      logDebug("✅ Storage permission granted");
    } else {
      logDebug("❌ Storage permission denied");
    }
  }
}
