import 'package:anime_app_tv/app/core/common/utils/toasting.dart';
import 'package:flutter/services.dart';

class Utils {
  static void copy(context, String text, {bool logged = false}) async {
    await Clipboard.setData(ClipboardData(text: text));
    Toasting.success(context, message: 'Copiado com sucesso!');
  }

  static int? extractInt(String? text) {
    if (text == null) return null;
    return int.tryParse(text.replaceAll(RegExp(r'[^0-9]'), ''));
  }
}
