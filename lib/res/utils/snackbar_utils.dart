import 'dart:io';

import 'package:flutter/cupertino.dart'
    show showCupertinoDialog, CupertinoAlertDialog, CupertinoDialogAction;
import 'package:flutter/material.dart';

class SnackbarUtils {
  /// This method is to show [bottom snackbar] to user.
  /// It accepts two required arguments: [context] and [label].
  ///
  /// By default it's background color is [Grey]. You can pass any color you want
  /// to [bgColor].
  ///
  /// If you want [undo] button, then you just need to pass [onUndo].
  /// You can also pass the [label] for undo using [actionLabel].
  static bottomSnackbar(
    BuildContext context,
    String label, {
    String? iosHeading, // This is for IOS
    Color? bgColor,
    String actionLabel = 'OK',
    bool isDangerous = false,
  }) {
    if (Platform.isAndroid) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.endToStart,
          backgroundColor: isDangerous ? Colors.red : bgColor,
          content: Text(label),
          behavior: SnackBarBehavior.floating, // This keeps FAB from moving
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: iosHeading != null ? Text(iosHeading) : null,
            content: Text(label),
            actions: [
              CupertinoDialogAction(
                child: Text(actionLabel),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
  }
}
