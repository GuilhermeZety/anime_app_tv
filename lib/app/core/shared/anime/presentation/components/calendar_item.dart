import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:anime_app_tv/app/core/common/constants/app_routes.dart';
import 'package:anime_app_tv/app/core/common/extensions/context_extension.dart';
import 'package:anime_app_tv/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app_tv/app/core/shared/anime/anime_logic.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/calendar_entity.dart';
import 'package:anime_app_tv/app/ui/components/image_cached.dart';
import 'package:anime_app_tv/app/ui/components/tag.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

class CalendarItem extends StatefulWidget {
  const CalendarItem({super.key, required this.anime});

  final CalendarAnimeEntity anime;

  @override
  State<CalendarItem> createState() => _CalendarItemState();
}

class _CalendarItemState extends State<CalendarItem> {
  bool hooved = false;

  @override
  Widget build(BuildContext context) {
    var favorited = AnimeLogic.getFavoriteAnime(widget.anime.uuid) != null;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        hooved = true;
        if (mounted) setState(() {});
      },
      onExit: (_) {
        hooved = false;
        if (mounted) setState(() {});
      },
      child: GestureDetector(
        onTap: () {
          Modular.to.pushNamed(AppRoutes.anime, arguments: widget.anime.toAnime());
        },
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            transform: hooved ? (Matrix4.identity()..scale(0.96)) : Matrix4.identity(),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: ImageCached(url: widget.anime.image ?? ''),
                        ),
                      ),
                      Positioned.fill(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                if (hooved) ...<Color>[
                                  Colors.transparent,
                                  AppColors.grey_600.withOpacity(0.2),
                                  AppColors.grey_600.withOpacity(0.7),
                                  AppColors.grey_600,
                                ] else ...[
                                  Colors.transparent,
                                  AppColors.grey_600.withOpacity(0.2),
                                  AppColors.grey_600.withOpacity(0.5),
                                  AppColors.grey_600,
                                ],
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () async {
                            ///TODO: set favorite

                            // await AnimeLogic.setFavoriteCalendar(widget.anime);
                            // favorited = !favorsited;
                            // if (mounted) setState(() {});
                          },
                          child: Builder(
                            builder: (_) {
                              if (favorited) {
                                return const Icon(
                                  Icons.favorite,
                                  color: AppColors.pink_400,
                                );
                              }
                              return const Icon(
                                Icons.favorite,
                                shadows: <Shadow>[
                                  Shadow(
                                    color: Colors.white54,
                                    blurRadius: 15.0,
                                  ),
                                ],
                                color: AppColors.grey_600,
                              );
                            },
                          ),
                        ),
                      ),
                      if (widget.anime.type != null)
                        Positioned(
                          left: 10,
                          top: 10,
                          child: SeparatedColumn(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            separatorBuilder: () => const Gap(5),
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Tag(
                                text: widget.anime.type!,
                              ),
                            ],
                          ),
                        ),
                      if (widget.anime.date != null)
                        Positioned(
                          right: 10,
                          bottom: 10,
                          child: SeparatedColumn(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            separatorBuilder: () => const Gap(5),
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Tag(
                                text: widget.anime.date!,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ).expanded(),
                Row(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(
                          10,
                        ),
                        child: AutoSizeText(
                          widget.anime.name,
                          maxLines: 2,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.grey_200,
                            fontWeight: FontWeight.bold,
                            fontSize: context.isLandscape ? 14 : 12,
                          ),
                        ),
                      ),
                    ).expanded(),
                  ],
                ).tooltip(widget.anime.name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
