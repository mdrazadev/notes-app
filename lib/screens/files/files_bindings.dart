import 'package:get/get.dart';
import 'package:notes_app/screens/files/files_vm.dart';

class FilesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilesVM>(() => FilesVM());
  }
}
