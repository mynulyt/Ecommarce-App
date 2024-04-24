import 'package:ecommarce/core/constains/my_colors.dart';
import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Widget icon;
  const CircleButton({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
          color: MyColors.borderColor,
        ),
      ),
      child: icon,
    );
  }
}
