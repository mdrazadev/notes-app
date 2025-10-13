import 'package:flutter/material.dart';
import 'package:notes_app/res/extensions/color_extsion.dart';

class AddFolderWidget extends StatelessWidget {
  const AddFolderWidget({
    super.key,
    required this.controller,
    required this.onFolderAdd,
  });

  final TextEditingController controller;
  final VoidCallback onFolderAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      // contentPadding: EdgeInsets.zero,
      type: MaterialType.transparency,
      elevation: 2.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(end: 20.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondarytheme,
                borderRadius: BorderRadiusDirectional.circular(5.0),
              ),
              child: TextField(
                textDirection: Directionality.of(context),
                controller: controller,
                style: theme.textTheme.titleSmall,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  border: InputBorder.none,
                  hintText: "Enter folder name",
                ),
              ),
            ),
            Positioned.directional(
              textDirection: Directionality.of(context),
              end: 0,
              child: InkWell(
                onTap: onFolderAdd,
                child: Container(
                  padding: const EdgeInsets.all(11.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.blacktheme,
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: theme.colorScheme.secondarytheme,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
