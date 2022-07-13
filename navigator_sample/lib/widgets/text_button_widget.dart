import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({required this.title, required this.onTap, Key? key})
      : super(key: key);
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(title, style: Theme.of(context).textTheme.headline3)),
      ),
    );
  }
}
