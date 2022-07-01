import 'package:flutter/material.dart';

class TopicButtonWidget extends StatelessWidget {
  const TopicButtonWidget({required this.title, required this.onTap, Key? key})
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
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFFE2E2E2),
              ),
            ),
          ),
        ));
  }
}
