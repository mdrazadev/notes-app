import 'package:get/get.dart';
import 'package:notes_app/screens/login/auth_vm.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthVM>(() => AuthVM());
  }
}
