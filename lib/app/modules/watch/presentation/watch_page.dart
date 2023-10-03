import 'dart:developer';
import 'dart:io';

import 'package:anime_app_tv/app/core/common/enums/video_quality_enum.dart';
import 'package:anime_app_tv/app/core/common/extensions/context_extension.dart';
import 'package:anime_app_tv/app/core/common/integrations/animetube.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/episode/episode_data_entity.dart';
import 'package:anime_app_tv/app/ui/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class WatchPage extends StatefulWidget {
  const WatchPage({
    super.key,
    required this.episodeData,
    required this.quality,
    required this.anime,
  });

  final EpisodeDataEntity episodeData;
  final VideoQualityEnum quality;
  final AnimeEntity anime;

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  // Create a [Player] to control playback.
  late final player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);

  @override
  void initState() {
    super.initState();
    openVideo(widget.episodeData);
  }

  void openVideo(EpisodeDataEntity episodeDataEntity) {
    player.open(
      Media(
        'https://ikaros.anicdn.net/${Anitube().getResolution(widget.quality, episodeDataEntity.containsTwo ?? false)}/${episodeDataEntity.videoUuid}.mp4',
        httpHeaders: {
          'Content-Type': 'video/mp4',
          'Referer': 'https://www.anitube.vip/',
        },
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.episodeData.name ?? widget.anime.name ?? ''),
      ),
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: Stack(
          children: [
            Video(
              controller: controller,
              onEnterFullscreen: onEnterFullScreen,
            ),
            if (widget.episodeData.nextEpisodeUuid != null)
              Positioned(
                bottom: 100,
                right: 30,
                child: Opacity(
                  opacity: 0.5,
                  child: Button(
                    child: const Text('Próximo EP'),
                    onPressed: () async {
                      // Modular.to.pushReplacementNamed(AppRoutes.watch, [episodeData, quality, anime]);s
                    },
                  ),
                ),
              ),
            if (widget.episodeData.previousEpisodeUuid != null)
              Positioned(
                bottom: 100,
                left: 30,
                child: Opacity(
                  opacity: 0.5,
                  child: Button(
                    child: const Text('EP Anterior'),
                    onPressed: () async {
                      //
                      log('Anterior');
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> onEnterFullScreen() async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        await Future.wait(
          [
            SystemChrome.setEnabledSystemUIMode(
              SystemUiMode.immersiveSticky,
              overlays: [],
            ),
            SystemChrome.setPreferredOrientations(
              [
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ],
            ),
          ],
        );
      } else if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
        await const MethodChannel('com.alexmercerind/media_kit_video').invokeMethod(
          'Utils.EnterNativeFullscreen',
        );
      }
    } catch (exception, stacktrace) {
      debugPrint(exception.toString());
      debugPrint(stacktrace.toString());
    }
  }
}
