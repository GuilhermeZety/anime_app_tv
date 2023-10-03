import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension Expanding on Widget {
  Widget expanded({int flex = 1}) => Expanded(flex: flex, child: this);

  Widget expandedH({int flex = 1}) => Row(children: [Expanded(flex: flex, child: this)]);
}

extension Heroic on Widget {
  Widget hero(String? tag) => tag != null
      ? Hero(
          tag: tag,
          child: this,
        )
      : this;
}

extension Shimmer on Widget {
  Widget shim() => animate(
        onPlay: (controller) => controller.repeat(),
      ).shimmer(
        duration: 3.seconds,
        color: AppColors.grey_300.withOpacity(0.4),
      );
}

extension Tooltiped on Widget {
  Widget tooltip(String message) => Tooltip(
        message: message,
        verticalOffset: -60,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.grey_600,
          border: Border.all(color: AppColors.grey_200),
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(fontSize: 12),
        child: this,
      );
}
