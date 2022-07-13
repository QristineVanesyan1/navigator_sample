import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

enum CircularImageSize {
  big,
  medium,
  small;

  double getHeight() {
    switch (this) {
      case CircularImageSize.big:
        return 160;
      case CircularImageSize.medium:
        return 120;
      case CircularImageSize.small:
        return 80;
    }
  }
}

class CircularImageWidget extends StatelessWidget {
  const CircularImageWidget(
      {required this.url, this.size = CircularImageSize.small, Key? key})
      : super(key: key);
  final String url;
  final CircularImageSize size;
  @override
  Widget build(BuildContext context) {
    final double avatarSize = size.getHeight();
    final double border = avatarSize / 2;
    return ClipRRect(
      borderRadius: BorderRadius.circular(border),
      child: ImageNetwork(
        image: url,
        height: avatarSize,
        width: avatarSize,
      ),
    );
  }
}
