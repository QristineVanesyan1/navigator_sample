import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({required this.title, required this.onTap, Key? key})
      : super(key: key);
  final String title;
  final VoidCallback onTap;

  @override
  //todo set hover on mouse
  Widget build(BuildContext context) {
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(title, style: Theme.of(context).textTheme.headline3),
          ),
        ));
  }
}
