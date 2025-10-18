// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:notes_app/res/mixins/logger_mixin.dart';
import 'package:notes_app/res/routes/routes_name.dart';
import 'package:notes_app/res/services/auth_service.dart';
import 'package:notes_app/res/utils/snackbar_utils.dart';

class AuthVM extends GetxController with LoggerMixin {
  RxBool isLoading = false.obs;
  RxBool isLogin = true.obs;
  RxBool isPassVisible = false.obs;

  final AuthService _authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusnode = FocusNode();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> login(BuildContext context) async {
    isLoading.value = true;
    _authService
        .login(emailController.text.trim(), passwordController.text)
        .then((response) {
          if (response != null) {
            isLoading.value = false;
            logDebug("Login successfully");
            Get.offAllNamed(RoutesName.home);
          } else {
            isLoading.value = false;
            logDebug("Login failed");
            SnackbarUtils.bottomSnackbar(
              context,
              "Email or password is incorrect",
            );
          }
        })
        .onError((error, stackTrace) {
          isLoading.value = false;
          SnackbarUtils.bottomSnackbar(
            context,
            error.toString(),
            isDangerous: true,
          );
        });
  }

  Future<void> signUp(BuildContext context) async {
    _authService
        .signUp(emailController.text.trim(), passwordController.text)
        .then((response) {
          if (response != null) {
            isLogin.value = true;
            isLoading.value = false;
            logDebug("Sign up successfully");
          } else {
            isLoading.value = false;
            logDebug("Sign up failed");
            SnackbarUtils.bottomSnackbar(
              context,
              "Email or password is incorrect",
            );
          }
        })
        .onError((error, stackTrace) {
          isLoading.value = false;
          logDebug("Sign up failed");
          SnackbarUtils.bottomSnackbar(
            context,
            error.toString(),
            isDangerous: true,
          );
        });
  }
}
