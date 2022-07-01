import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
        indent: MediaQuery.of(context).size.width * 0.01,
        endIndent: MediaQuery.of(context).size.width * 0.01);
  }
}
