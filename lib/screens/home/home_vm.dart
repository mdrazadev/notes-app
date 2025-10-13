import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/res/extensions/color_extsion.dart';
import 'package:notes_app/screens/home/widgets/add_folder_widget.dart'
    show AddFolderWidget;

class HomeVM extends GetxController {
  RxBool isLoading = false.obs;

  final TextEditingController controller = TextEditingController();

  RxList<String> foldersList =
      <String>[
        "Begin",
        "Ideas",
        "Inspiration",
        "Projects",
        "Self care",
        "Travel ideas",
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
              onFolderAdd: () {
                Get.back();
                isLoading.value = true;
                foldersList.insert(0, controller.text);
                controller.clear();
                isLoading.value = false;
              },
            ),
          ),
        );
      },
    );
  }
}
