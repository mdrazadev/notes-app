import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/res/widgets/loaders/loader_widget.dart';
import 'package:notes_app/screens/login/auth_vm.dart';

class LoginV extends StatelessWidget {
  const LoginV({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<AuthVM>();
    return Scaffold(
      body: Obx(
        () =>
            vm.isLoading.value
                ? LoaderWidget()
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: vm.formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 100),
                        TextFormField(
                          controller: vm.emailController,
                          keyboardType: TextInputType.emailAddress,
                          autofocus: true,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: InputBorder.none,
                            // isDense: true,
                            contentPadding: EdgeInsets.only(left: 8),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                          onFieldSubmitted:
                              (value) => vm.passwordFocusnode.requestFocus(),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          obscureText: !vm.isPassVisible.value,
                          controller: vm.passwordController,
                          focusNode: vm.passwordFocusnode,
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: InputBorder.none,
                            // isDense: true,
                            contentPadding: EdgeInsets.only(left: 8),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                vm.isPassVisible.value =
                                    !vm.isPassVisible.value;
                              },
                              icon: Obx(
                                () =>
                                    vm.isPassVisible.value
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        SizedBox(
                          width: Get.width,
                          child: ElevatedButton(
                            onPressed:
                                () =>
                                    vm.isLogin.value
                                        ? vm.login(context)
                                        : vm.signUp(context),
                            child: Obx(
                              () => Text(vm.isLogin.value ? "Login" : "Signup"),
                            ),
                          ),
                        ),

                        SizedBox(height: 100),
                        TextButton(
                          onPressed: () => vm.isLogin.value = !vm.isLogin.value,
                          child: Obx(
                            () => Text(
                              vm.isLogin.value
                                  ? "Don’t have an account? Sign up"
                                  : "Already have an account? Login",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
      ),
    );
  }
}
