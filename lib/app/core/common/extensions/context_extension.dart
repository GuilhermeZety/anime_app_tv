import 'dart:io';
import 'dart:math';

import 'package:anime_app_tv/app/core/common/enums/layout_type.dart';
import 'package:flutter/material.dart';

extension GetTheme on BuildContext {
  Size get _size => MediaQuery.sizeOf(this);

  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  bool isMobile() => _size.shortestSide < 600;
  bool isTablet() => _size.shortestSide >= 600 && _size.shortestSide < 900;
  bool isDesktop() => _size.shortestSide >= 900;

  LayoutTypes get layout => isMobile()
      ? LayoutTypes.mobile
      : isTablet()
          ? LayoutTypes.tablet
          : LayoutTypes.desktop;

  double get scale {
    if (isDesktop()) {
      return 1.40;
    } else if (isTablet()) {
      return 1.25;
    } else {
      return 1;
    }
  }

  double get pixelsPerInch => Platform.isAndroid || Platform.isIOS ? 150 : 96;

  /// Returns same as MediaQuery.of(context)
  MediaQueryData get mq => MediaQuery.of(this);

  /// Returns if Orientation is landscape
  bool get isLandscape => mq.orientation == Orientation.landscape;

  /// Returns same as MediaQuery.of(context).size
  Size get size => mq.size;

  /// Returns same as MediaQuery.of(context).size.width
  double get width => size.width;

  /// Returns same as MediaQuery.of(context).height
  double get height => size.height;

  /// Returns diagonal screen pixels
  double get diagonal {
    final Size s = size;
    return sqrt((s.width * s.width) + (s.height * s.height));
  }

  /// Returns pixel size in Inches
  Size get sizeInches {
    final Size pxSize = size;
    return Size(pxSize.width / pixelsPerInch, pxSize.height / pixelsPerInch);
  }

  /// Returns screen width in Inches
  double get widthInches => sizeInches.width;

  /// Returns screen height in Inches
  double get heightInches => sizeInches.height;

  /// Returns screen diagonal in Inches
  double get diagonalInches => diagonal / pixelsPerInch;

  /// Returns fraction (0-1) of screen width in pixels
  double widthPct(double fraction) => fraction * width;

  /// Returns fraction (0-1) of screen height in pixels
  double heightPct(double fraction) => fraction * height;
}
