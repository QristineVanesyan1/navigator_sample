import 'package:flutter/material.dart';
import 'package:navigator_sample/styles/colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
        color: AppColors.white.withOpacity(0.7),
        indent: MediaQuery.of(context).size.width * 0.1,
        endIndent: MediaQuery.of(context).size.width * 0.1);
  }
}
