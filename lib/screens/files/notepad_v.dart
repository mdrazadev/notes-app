import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/res/extensions/color_extsion.dart';
import 'package:notes_app/res/utils/my_date_utils.dart';
import 'package:notes_app/screens/files/files_vm.dart';

class NotepadV extends StatelessWidget {
  const NotepadV({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<FilesVM>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${MyDateUtils.formatDate(DateTime.now())} | ${vm.parentDirName}",
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        backgroundColor: Theme.of(context).colorScheme.primarytheme,
        foregroundColor: Theme.of(context).colorScheme.blacktheme,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => vm.createFile(context),
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Form(
                  key: vm.formKey,
                  child: TextFormField(
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLength: 25,
                    controller: vm.headingController,
                    decoration: InputDecoration(
                      hintText: "Heading",
                      hintStyle: Theme.of(context).textTheme.titleLarge,
                      counterText: "",
                      border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a heading";
                      }
                      return null;
                    },
                    onFieldSubmitted:
                        (value) => vm.contentFocusnode.requestFocus(),
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  maxLines: 1000,
                  controller: vm.contentController,
                  focusNode: vm.contentFocusnode,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
