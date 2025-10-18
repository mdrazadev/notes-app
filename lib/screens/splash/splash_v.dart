import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/res/routes/routes_name.dart';

class SplashV extends StatefulWidget {
  const SplashV({super.key});

  @override
  State<SplashV> createState() => _SplashVState();
}

class _SplashVState extends State<SplashV> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(RoutesName.auth);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Notes...",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25),
        ),
      ),
    );
  }
}
