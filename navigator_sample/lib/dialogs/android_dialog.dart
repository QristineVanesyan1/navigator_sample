import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:navigator_sample/dialogs/custom_dialog.dart';

class AndroidDialog extends CustomDialog {
  AndroidDialog({required this.message});
  final String message;

  @override
  Widget create(BuildContext context) {
    return AlertDialog(
      title: Text(getTitle()),
      content: Text(message),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'))
      ],
    );
  }

  @override
  String getTitle() {
    return 'Android Dialog';
  }
}
