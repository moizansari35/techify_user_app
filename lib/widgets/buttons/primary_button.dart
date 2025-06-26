import 'package:flutter/material.dart';
import 'package:techify/constants/colors.dart';

class MyPrimaryButton extends StatelessWidget {
  final void Function() onPressed;
  final String title;
  const MyPrimaryButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: MyColors.whiteColor,
          ),
        ),
      ),
    );
  }
}
