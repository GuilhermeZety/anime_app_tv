import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Colors.white;
  static const Color grey_100 = Color(0xFFE9E9E9);
  static const Color grey_200 = Color(0xFFB4B4B4);
  static const Color grey_300 = Color(0xFF555555);
  static const Color grey_400 = Color(0xFF373737);
  static const Color grey_500 = Color(0xFF303030);
  static const Color grey_600 = Color(0xFF232323);
  static const Color grey_700 = Color(0xFF1f1e20);
  static const Color grey_900 = Color(0xFF17131B);
  static const Color black = Colors.black;

  static const Color pink_400 = Color(0xFFEA335F);
  static const Color pink_800 = Color(0xFFEA335F);

  // static const Color purple_400 = Color(0xFF9333EA);
  static const Color purple_800 = Color(0xFF1B0431);

  static const Color green_400 = Color(0xFF52FF00);

  static const Color red_400 = Color(0xFFFF0000);
  static const Color red_600 = Color(0xFF9B0F0F);

  static LinearGradient backgrondGradient = const LinearGradient(
    colors: [
      grey_600,
      grey_900,
    ],
    tileMode: TileMode.mirror,
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}
