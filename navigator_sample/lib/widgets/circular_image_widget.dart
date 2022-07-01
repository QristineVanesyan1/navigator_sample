import 'package:flutter/material.dart';
import 'package:navigator_sample/styles/colors.dart';

class CircularImageWidget extends StatelessWidget {
  const CircularImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CircleAvatar(
        backgroundColor: AppColors.darkGrey,
        radius: 75,
        foregroundColor: AppColors.darkGrey,
      ),
    );
  }
}
