import 'package:anime_app_tv/app/core/common/constants/app_assets.dart';
import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:anime_app_tv/app/core/common/constants/app_routes.dart';
import 'package:anime_app_tv/app/core/common/extensions/context_extension.dart';
import 'package:anime_app_tv/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app_tv/app/ui/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class NotConnectionPage extends StatefulWidget {
  const NotConnectionPage({super.key});

  @override
  State<NotConnectionPage> createState() => _NotConnectionPageState();
}

class _NotConnectionPageState extends State<NotConnectionPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: AppColors.backgrondGradient,
      body: Container(
        padding: const EdgeInsets.all(30),
        height: context.height,
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: context.height * 0.2),
              child: SvgPicture.asset(
                AppAssets.logo,
                width: 120,
              ).hero('logo'),
            ),
            const Gap(50),
            const Text(
              'Ops!',
              style: TextStyle(
                color: AppColors.grey_100,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(10),
            const Text(
              'Parece que você está sem conexão com a internet. \n\nVerifique sua conexão e tente novamente.',
              style: TextStyle(
                color: AppColors.grey_100,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Button(
              onPressed: () async => Modular.to.pushNamedAndRemoveUntil(
                AppRoutes.splash,
                (_) => false,
              ),
              child: const Text('Tentar novamente'),
            ).expandedH(),
          ],
        ),
      ),
    );
  }
}
