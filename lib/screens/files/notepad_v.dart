import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/screens/files/files_vm.dart';

class NotepadV extends StatelessWidget {
  const NotepadV({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<FilesVM>();
    return Scaffold();
  }
}
