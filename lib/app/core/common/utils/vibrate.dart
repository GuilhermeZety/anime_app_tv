import 'dart:io';

import 'package:flutter_vibrate/flutter_vibrate.dart';

void vibrate(FeedbackType type) async {
  if (Platform.isAndroid || Platform.isIOS) {
    if (await Vibrate.canVibrate) {
      Vibrate.feedback(type);
    }
  }
}
