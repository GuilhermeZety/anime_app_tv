import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.size, this.inverted = false});

  final double? size;
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? 30,
      child: LoadingAnimationWidget.fourRotatingDots(
        color: inverted ? AppColors.grey_100 : AppColors.pink_400,
        size: size ?? 30,
      ),
    );
  }
}
