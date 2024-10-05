import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlertDialogComp {
  Future<bool> alertDialog({
    required String title,
    required String message,
    String actionConfirm = "はい",
    String actionDisable = "いいえ",
    required BuildContext context,
  }) async {
    final bool dialog = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              context.pop(true);
            },
            child: Text(actionConfirm),
          ),
          TextButton(
            onPressed: () {
              context.pop(false);
            },
            child: Text(actionDisable),
          ),
        ],
      ),
    );

    return dialog;
  }
}
