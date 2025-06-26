import 'package:flutter/material.dart';
import 'package:techify/constants/sized_box.dart';

class TopTitles extends StatelessWidget {
  final String title, subtitle;

  const TopTitles({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: kTextTabBarHeight,
        ),
        if (title == "Login" || title == "Create Account")
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
        10.height,
        Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(fontSize: 18.0),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
