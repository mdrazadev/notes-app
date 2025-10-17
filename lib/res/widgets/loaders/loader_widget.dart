import 'package:flutter/material.dart';
import 'package:notes_app/res/extensions/color_extsion.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: CircularProgressIndicator(color: theme.colorScheme.blacktheme),
    );
  }
}
