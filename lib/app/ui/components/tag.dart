import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  const Tag({super.key, required this.text, this.color = AppColors.grey_600});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.grey_200,
          fontSize: 12,
        ),
      ),
    );
  }
}
