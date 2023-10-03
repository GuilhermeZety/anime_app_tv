import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:anime_app_tv/app/core/common/extensions/context_extension.dart';
import 'package:anime_app_tv/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app_tv/app/modules/home/presentation/components/bottom_bar.dart';
import 'package:anime_app_tv/app/modules/home/presentation/components/home_appbar.dart';
import 'package:anime_app_tv/app/modules/home/presentation/cubit/home_cubit.dart';
import 'package:anime_app_tv/app/modules/home/presentation/pages/initial/initial_page.dart';
import 'package:anime_app_tv/app/ui/components/coming_soon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final HomeCubit _cubit = Modular.get();
  @override
  void initState() {
    _cubit.controller = TabController(length: 4, vsync: this);

    _cubit.controller.addListener(_cubit.onTabControllerChange);
    super.initState();
  }

  @override
  void dispose() {
    _cubit.controller.removeListener(_cubit.onTabControllerChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: _cubit,
        builder: (context, state) {
          if (context.isLandscape) {
            return ScaffoldGradientBackground(
              gradient: AppColors.backgrondGradient,
              body: Row(
                children: [
                  _content.expanded(),
                ],
              ),
            );
          }
          return ScaffoldGradientBackground(
            appBar: const HomeAppbar(),
            gradient: AppColors.backgrondGradient,
            bottomNavigationBar: const BottomBar(),
            body: _content,
          );
        },
      ),
    );
  }

  Widget get _content => TabBarView(
        controller: _cubit.controller,
        children: const [
          InitialPage(),
          Center(child: ComingSoon()),
          Center(child: ComingSoon()),
          Center(child: ComingSoon()),
        ],
      );
}
