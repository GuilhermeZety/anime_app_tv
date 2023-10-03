import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({super.key, required this.value, this.size = 50, required this.onSelect});

  final bool value;
  final double size;
  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: value ? AppColors.pink_400 : AppColors.grey_300,
          borderRadius: BorderRadius.circular(size * 0.25),
        ),
        child: Center(
          child: value
              ? Icon(
                  Icons.close_rounded,
                  size: size * 0.8,
                  weight: 3,
                )
              : Icon(
                  Icons.circle_outlined,
                  size: size * 0.8,
                ),
        ),
      ),
    );
  }
}
