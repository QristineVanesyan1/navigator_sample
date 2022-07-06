import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:navigator_sample/dialogs/custom_dialog.dart';

class IOSDialog extends CustomDialog {
  IOSDialog({required this.message});
  final String message;

  @override
  Widget create(BuildContext context) {
    return CupertinoAlertDialog(
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
    return 'IOS dialog';
  }
}
