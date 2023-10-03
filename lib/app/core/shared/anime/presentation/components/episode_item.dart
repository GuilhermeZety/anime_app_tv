import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:anime_app_tv/app/core/common/extensions/context_extension.dart';
import 'package:anime_app_tv/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app_tv/app/core/shared/anime/anime_logic.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/episode/episode_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/presentation/dialogs/watch_modal/watch_anime_modal.dart';
import 'package:anime_app_tv/app/ui/components/image_cached.dart';
import 'package:anime_app_tv/app/ui/components/tag.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class EpisodeItem extends StatefulWidget {
  const EpisodeItem({super.key, required this.episode, this.anime, this.page});

  final AnimeEntity? anime;
  final int? page;
  final EpisodeEntity episode;

  @override
  State<EpisodeItem> createState() => _EpisodeItemState();
}

class _EpisodeItemState extends State<EpisodeItem> {
  bool hooved = false;

  @override
  Widget build(BuildContext context) {
    bool watched = false;
    Color color = Colors.white;
    if (widget.anime != null) {
      watched = AnimeLogic.getAnimeWatchEps(widget.anime!.uuid).where((element) => element['ep'] == widget.episode.uuid).isNotEmpty;
    }
    return Focus(
      onFocusChange: (focused) {
        setState(() {
          color = focused ? Colors.black26 : Colors.white;
        });
      },
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
          WatchAnimeModal(
            episode: widget.episode,
            anime: widget.anime,
            page: widget.page,
          ).show(context);
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
          onTapDown: (_) {
            hooved = true;
            if (mounted) setState(() {});
          },
          onTapUp: (_) {
            hooved = false;
            if (mounted) setState(() {});
          },
          onTapCancel: () {
            hooved = false;
            if (mounted) setState(() {});
          },
          onTap: () async {
            await WatchAnimeModal(
              episode: widget.episode,
              anime: widget.anime,
              page: widget.page,
            ).show(context);
            if (mounted) setState(() {});
          },
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: color,
                  width: 1,
                ),
              ),
              transform: hooved ? (Matrix4.identity()..scale(0.98)) : Matrix4.identity(),
              child: Stack(
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: ImageCached(url: widget.episode.image ?? ''),
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
                                        AppColors.grey_600.withOpacity(0.8),
                                      ],
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              ),
                            ),
                            if (widget.episode.duration != null)
                              Positioned(
                                left: 10,
                                top: 10,
                                child: Tag(
                                  text: widget.episode.duration!,
                                ),
                              ),
                            Positioned(
                              right: 10,
                              top: 10,
                              child: Tag(
                                text: 'EP ${widget.episode.episode}',
                              ),
                            ),
                          ],
                        ),
                      ).expanded(),
                      SizedBox(
                        height: 50,
                        width: context.width,
                        child: Padding(
                          padding: const EdgeInsets.all(
                            10,
                          ),
                          child: AutoSizeText(
                            widget.episode.name ?? '',
                            maxLines: 2,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: AppColors.grey_200,
                              fontWeight: FontWeight.bold,
                              fontSize: context.isLandscape ? 14 : 12,
                            ),
                          ),
                        ),
                      ).tooltip(widget.episode.name ?? ''),
                    ],
                  ),
                  if (watched)
                    Positioned.fill(
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: AppColors.grey_200.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check,
                              color: AppColors.grey_100,
                            ),
                            Gap(5),
                            Text(
                              'Assistido',
                              style: TextStyle(
                                color: AppColors.grey_100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
