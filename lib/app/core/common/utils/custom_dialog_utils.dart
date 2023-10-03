import 'dart:io';

import 'package:anime_app_tv/app/core/common/extensions/context_extension.dart';
import 'package:flutter/material.dart';

Future<T?> showCustomDialog<T>(
  BuildContext context, {
  required Widget child,
}) async {
  if (Platform.isAndroid || Platform.isIOS) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxHeight: context.height * 0.95,
        minHeight: context.height * 0.4,
      ),
      isDismissible: true,
      isScrollControlled: true,
      enableDrag: false,
      elevation: 0,
      builder: (context) => child,
    );
  } else {
    return showDialog<T>(
      context: context,
      barrierDismissible: true,
      builder: (context) => Center(child: child),
    );
  }
}
