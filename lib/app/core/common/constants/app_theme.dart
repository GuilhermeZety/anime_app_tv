import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:anime_app_tv/app/core/common/extensions/color_extension.dart';
import 'package:flutter/material.dart';

/// > A class that contains all the colors used in the app
class AppTheme {
  static ThemeData get dark => ThemeData(
        fontFamily: 'RobotoSlab',
        primarySwatch: AppColors.pink_400.toMaterialColor(),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: AppColors.pink_400,
          cursorColor: AppColors.pink_400,
          selectionColor: AppColors.pink_400.withOpacity(0.2),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: AppColors.grey_100, letterSpacing: 0.4),
          displayMedium: TextStyle(color: AppColors.grey_100, letterSpacing: 0.4),
          bodyMedium: TextStyle(color: AppColors.grey_100, letterSpacing: 0.4),
          titleMedium: TextStyle(color: AppColors.grey_100, letterSpacing: 0.4),
        ),
      ).copyWith(
        scaffoldBackgroundColor: AppColors.grey_600,
        canvasColor: AppColors.grey_200,
        primaryColor: AppColors.grey_200,
        colorScheme: const ColorScheme.dark().copyWith(
          secondary: AppColors.grey_200,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: AppColors.grey_500,
          isDense: false,
          prefixIconColor: AppColors.grey_100,
          labelStyle: TextStyle(
            color: AppColors.grey_100,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          hintStyle: TextStyle(
            color: AppColors.grey_300,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: AppColors.grey_300,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
          //DISABLE  ------
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 0,
              color: Colors.transparent,
            ),
          ),
          //ERROR  ------
          errorStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.red,
            ),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 2, color: Colors.red),
          ),
        ),
      );
}
