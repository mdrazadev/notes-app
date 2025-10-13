import 'package:get/get.dart';
import 'package:notes_app/screens/home/home_vm.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeVM>(() => HomeVM());
  }
}
