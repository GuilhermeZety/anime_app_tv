import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.backAction});

  final void Function() backAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 120,
      leading: Row(
        children: [
          GestureDetector(
            onTap: backAction,
            child: Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: const BoxDecoration(
                color: AppColors.grey_600,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.keyboard_arrow_left_rounded),
                  Gap(10),
                  Text(
                    'Sair',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 60);
}
