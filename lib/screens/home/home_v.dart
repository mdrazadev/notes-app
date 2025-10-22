// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:notes_app/res/extensions/color_extsion.dart';
// import 'package:notes_app/res/routes/routes_name.dart';
// import 'package:notes_app/res/widgets/loaders/loader_widget.dart'
//     show LoaderWidget;
// import 'package:notes_app/screens/home/home_vm.dart';

// class HomeV extends StatelessWidget {
//   const HomeV({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final vm = Get.find<HomeVM>();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Folders"),
//         backgroundColor: theme.colorScheme.primarytheme,
//         foregroundColor: theme.colorScheme.blacktheme,
//         elevation: 0,
//         actions: [
//           IconButton(onPressed: () {}, icon: Icon(Icons.search)),
//           IconButton(onPressed: vm.logout, icon: Icon(Icons.logout)),
//         ],
//       ),
//       floatingActionButton: Obx(
//         () =>
//             vm.isLoading.value
//                 ? SizedBox.shrink()
//                 : FloatingActionButton(
//                   onPressed: () => vm.addFolderDialog(context),
//                   backgroundColor: theme.colorScheme.blacktheme,
//                   child: Icon(Icons.add),
//                 ),
//       ),
//       body: SafeArea(
//         child: Obx(
//           () =>
//               vm.isLoading.value
//                   ? LoaderWidget()
//                   : vm.foldersList.isEmpty
//                   ? const Center(child: Text("Empty"))
//                   : ListView.builder(
//                     itemCount: vm.foldersList.length,
//                     itemBuilder: (context, index) {
//                       final folder = vm.foldersList[index];
//                       return ListTile(
//                         title: Text(folder),
//                         trailing: Icon(Icons.keyboard_arrow_right),
//                         onTap:
//                             () => Get.toNamed(
//                               RoutesName.files,
//                               arguments: folder,
//                             ),
//                       );
//                     },
//                   ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
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
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: vm.logout, icon: Icon(Icons.logout)),
        ],
      ),
      floatingActionButton: Obx(
        () =>
            vm.isLoading.value
                ? SizedBox.shrink()
                : FloatingActionButton(
                  onPressed: () => vm.addFolderDialog(context),
                  backgroundColor: theme.colorScheme.blacktheme,
                  child: Icon(Icons.add),
                ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: vm.getFirebaseFolders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No folders yet."));
          }

          final folders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: folders.length,
            itemBuilder: (context, index) {
              final folder = folders[index];
              return ListTile(
                title: Text(folder['name']),
                trailing: Icon(Icons.keyboard_arrow_right),
              );
            },
          );
        },
      ),
    );
  }
}
