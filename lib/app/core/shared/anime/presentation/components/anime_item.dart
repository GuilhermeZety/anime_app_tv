import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:anime_app_tv/app/core/common/constants/app_routes.dart';
import 'package:anime_app_tv/app/core/common/extensions/context_extension.dart';
import 'package:anime_app_tv/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app_tv/app/core/shared/anime/anime_logic.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app_tv/app/ui/components/image_cached.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AnimeItem extends StatefulWidget {
  const AnimeItem({super.key, required this.anime});

  final AnimeEntity anime;

  @override
  State<AnimeItem> createState() => _AnimeItemState();
}

class _AnimeItemState extends State<AnimeItem> {
  bool hooved = false;
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    var favorited = AnimeLogic.getFavoriteAnime(widget.anime.uuid) != null;
    return Focus(
      onFocusChange: (focused) {
        setState(() {
          color = focused ? Colors.black26 : Colors.white;
        });
      },
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
          Modular.to.pushNamed(AppRoutes.anime, arguments: widget.anime);
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: MouseRegion(
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
            Modular.to.pushNamed(AppRoutes.anime, arguments: widget.anime);
          },
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
              ),
              transform: hooved ? (Matrix4.identity()..scale(0.96)) : Matrix4.identity(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: ImageCached(
                          url: widget.anime.image ?? '',
                          radius: 20,
                        ).hero(widget.anime.uuid),
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
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(
                            10,
                          ),
                          child: AutoSizeText(
                            widget.anime.name ?? '',
                            maxLines: 2,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white,
                              fontSize: context.isLandscape ? 14 : 12,
                            ),
                          ),
                        ).tooltip(widget.anime.name ?? ''),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: () async {
                          await AnimeLogic.setFavoriteAnime(widget.anime);
                          favorited = !favorited;
                          if (mounted) setState(() {});
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
