import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/res/extensions/color_extsion.dart';
import 'package:notes_app/screens/home/home_vm.dart';

class HomeV extends StatelessWidget {
  const HomeV({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vm = Get.find<HomeVM>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Folders"),
        backgroundColor: theme.colorScheme.primarytheme,
        foregroundColor: theme.colorScheme.blacktheme,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ),
        ],
      ),
      floatingActionButton: Obx(
        () =>
            vm.isLoading.value
                ? SizedBox.shrink()
                : FloatingActionButton(
                  onPressed: () => vm.addNewFolder(context),
                  backgroundColor: theme.colorScheme.blacktheme,
                  child: Icon(Icons.add),
                ),
      ),
      body: SafeArea(
        child: Obx(
          () =>
              vm.isLoading.value
                  ? Center(
                    child: CircularProgressIndicator(
                      color: theme.colorScheme.blacktheme,
                    ),
                  )
                  : vm.foldersList.isEmpty
                  ? const Center(child: Text("Empty"))
                  : ListView.builder(
                    itemCount: vm.foldersList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(vm.foldersList[index]),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {},
                      );
                    },
                  ),
        ),
      ),
    );
  }
}
