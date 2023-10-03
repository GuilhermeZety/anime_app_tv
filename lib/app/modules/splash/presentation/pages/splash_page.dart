import 'package:anime_app_tv/app/core/common/constants/app_assets.dart';
import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:anime_app_tv/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app_tv/app/modules/splash/splash_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashService service = SplashService();
  @override
  void initState() {
    super.initState();
    service.navigate(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: AppColors.backgrondGradient,
          ),
          child: Center(
            child: SvgPicture.asset(
              AppAssets.logo,
              width: 175,
            )
                .hero('logo')
                .animate(
                  onComplete: (c) => c.repeat(reverse: true),
                )
                .scaleXY(begin: 0.95, end: 1, delay: 1.5.seconds, duration: 1000.ms),
          ).animate().slideY(
                begin: -.2,
                end: 0,
                duration: 1500.ms,
                curve: Curves.bounceOut,
              ),
        ).animate().fade(duration: 1500.ms),
      ),
    );
  }
}
