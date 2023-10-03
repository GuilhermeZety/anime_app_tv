import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:anime_app_tv/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app_tv/app/modules/home/presentation/cubit/home_cubit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final HomeCubit _cubit = Modular.get();

  final qtdItens = 4;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _cubit,
      builder: (context, state) {
        return Container(
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.grey_600,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, -1),
              ),
            ],
          ),
          child: Column(
            children: [
              const Gap(5),
              LayoutBuilder(
                builder: (context, constraits) {
                  return Row(
                    children: [
                      AnimatedContainer(
                        duration: 200.ms,
                        height: 3,
                        margin: EdgeInsets.only(
                          left: (((constraits.maxWidth / qtdItens) * (_cubit.controller.index + 1)) - (constraits.maxWidth / qtdItens) / 2) - 15,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.pink_400,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        width: 30,
                      ),
                    ],
                  );
                },
              ).expanded(),
              LayoutBuilder(
                builder: (context, constraits) {
                  var width = constraits.maxWidth / qtdItens - 3;
                  return SeparatedRow(
                    separatorBuilder: () => const Gap(4),
                    children: [
                      BottomBarItem(
                        selected: _cubit.controller.index == 0,
                        ontap: () {
                          _cubit.controller.animateTo(0);
                          if (mounted) setState(() {});
                        },
                        icon: Icons.home_rounded,
                        name: 'Inicio',
                        width: width,
                      ),
                      BottomBarItem(
                        selected: _cubit.controller.index == 1,
                        icon: Icons.favorite_rounded,
                        name: 'Favoritos',
                        ontap: () {
                          _cubit.controller.animateTo(1);
                          if (mounted) setState(() {});
                        },
                        width: width,
                      ),
                      BottomBarItem(
                        icon: Icons.calendar_month,
                        selected: _cubit.controller.index == 2,
                        name: 'Calendário',
                        ontap: () {
                          _cubit.controller.animateTo(2);
                          if (mounted) setState(() {});
                        },
                        width: width,
                      ),
                      BottomBarItem(
                        selected: _cubit.controller.index == 3,
                        icon: Icons.person,
                        name: 'Perfil',
                        ontap: () {
                          _cubit.controller.animateTo(3);
                          if (mounted) setState(() {});
                        },
                        width: width,
                      ),
                    ],
                  );
                },
              ),
              const Gap(3),
            ],
          ),
        );
      },
    );
  }
}

class BottomBarItem extends StatelessWidget {
  const BottomBarItem({
    super.key,
    required this.name,
    required this.ontap,
    required this.icon,
    required this.selected,
    required this.width,
  });

  final String name;
  final IconData icon;
  final void Function() ontap;
  final bool selected;
  final double width;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          color: Colors.transparent,
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: selected ? AppColors.white : AppColors.grey_200,
              ),
              const Gap(2),
              AutoSizeText(
                name,
                maxLines: 1,
                style: TextStyle(
                  color: selected ? AppColors.white : AppColors.grey_200,
                  fontSize: 12,
                  overflow: TextOverflow.ellipsis,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
