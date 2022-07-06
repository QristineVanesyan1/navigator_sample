import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navigator_sample/constants/theme_params.dart';

class CircularImageWidget extends StatelessWidget {
  const CircularImageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CircleAvatar(
        backgroundColor: ThemeParams.darkGrey,
        radius: kIsWeb ? 75 : 40,
        foregroundColor: ThemeParams.darkGrey,
      ),
    );
  }
}
