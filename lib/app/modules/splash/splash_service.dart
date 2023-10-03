// ignore_for_file: use_build_context_synchronously

import 'package:anime_app_tv/app/core/common/constants/app_routes.dart';
import 'package:anime_app_tv/app/core/common/services/connection/connection_service.dart';
import 'package:anime_app_tv/app/core/common/utils/toasting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashService {
  Future<void> navigate(BuildContext context) async {
    try {
      if (await Modular.get<ConnectionService>().isConnected) {
        Future.delayed(3.seconds, () => Modular.to.navigate(AppRoutes.home));
        return;
      }
      Future.delayed(1.seconds, () => Modular.to.navigate(AppRoutes.notConnection));
      return;
    } catch (err) {
      Toasting.error(context, message: err.toString());
    }
  }
}
