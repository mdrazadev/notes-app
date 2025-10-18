import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/res/extensions/color_extsion.dart';
import 'package:notes_app/res/routes/routes_name.dart';
import 'package:notes_app/res/widgets/loaders/loader_widget.dart';
import 'package:notes_app/screens/files/files_vm.dart';

class FilesV extends StatelessWidget {
  const FilesV({super.key, required this.parentDirName});

  final String parentDirName;

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<FilesVM>();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(parentDirName),
        backgroundColor: theme.colorScheme.primarytheme,
        foregroundColor: theme.colorScheme.blacktheme,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(
            onPressed: () {
              vm.isListView.value = !vm.isListView.value;
            },
            icon: Obx(
              () => Icon(
                vm.isListView.value ? Icons.grid_view : Icons.list,
                // color: theme.colorScheme.primarytheme,
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: Obx(
        () =>
            vm.isLoading.value
                ? SizedBox.shrink()
                : FloatingActionButton(
                  // onPressed: () => vm.addFileDialog(context),
                  onPressed: () => vm.openNotepad(),
                  backgroundColor: theme.colorScheme.blacktheme,
                  child: Icon(Icons.add),
                ),
      ),

      body: Obx(
        () =>
            vm.isLoading.value
                ? LoaderWidget()
                : vm.filesList.isEmpty
                ? const Center(child: Text("Empty"))
                : vm.isListView.value
                ? ListView.builder(
                  itemCount: vm.filesList.length,
                  itemBuilder: (context, index) {
                    final file = vm.filesList[index];

                    final tempFileName = file.path.split("/").last;
                    final fileName = tempFileName.split(".").first;
                    return ListTile(title: Text(fileName));
                  },
                )
                : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemCount: vm.filesList.length,
                  itemBuilder: (context, index) {
                    final file = vm.filesList[index];
                    final tempFileName = file.path.split("/").last;
                    final fileName = tempFileName.split(".").first;
                    return Card(child: Center(child: Text(fileName)));
                  },
                ),
      ),
    );
  }
}
