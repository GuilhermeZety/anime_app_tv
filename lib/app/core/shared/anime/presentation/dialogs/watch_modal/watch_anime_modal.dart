import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:anime_app_tv/app/core/common/enums/video_quality_enum.dart';
import 'package:anime_app_tv/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app_tv/app/core/common/utils/custom_dialog_utils.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/episode/episode_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/presentation/dialogs/watch_modal/cubit/watch_anime_cubit.dart';
import 'package:anime_app_tv/app/ui/components/button.dart';
import 'package:anime_app_tv/app/ui/components/loader.dart';
import 'package:anime_app_tv/app/ui/dialogs/custom_dialog.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

class WatchAnimeModal extends StatefulWidget {
  const WatchAnimeModal({
    super.key,
    required this.episode,
    this.anime,
    this.page,
  });

  final AnimeEntity? anime;
  final int? page;
  final EpisodeEntity episode;

  Future show(
    BuildContext context,
  ) {
    return showCustomDialog(
      context,
      child: this,
    );
  }

  @override
  State<WatchAnimeModal> createState() => _WatchAnimeModalState();
}

class _WatchAnimeModalState extends State<WatchAnimeModal> {
  final WatchAnimeCubit cubit = WatchAnimeCubit();

  @override
  void initState() {
    cubit.init(widget.episode, widget.anime, widget.page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      top: const SizedBox(
        height: 0,
      ),
      bottom: BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state is WatchAnimeSelectQuality)
                Button(
                  onPressed: () async => cubit.watch(),
                  child: const Text('Assistir'),
                ).expandedH(),
              const Gap(10),
              Button.secondary(
                onPressed: () async => Modular.to.maybePop(),
                child: const Text('Fechar'),
              ).expandedH(),
            ],
          );
        },
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: content,
        ),
      ),
    );
  }

  Widget get content => BlocBuilder<WatchAnimeCubit, WatchAnimeState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is WatchAnimeLoading) {
            return const Column(
              children: [
                Text('Carregando dados do episodio...'),
                Gap(20),
                Loader(
                  size: 50,
                ),
              ],
            );
          } else if (state is WatchAnimeSelectQuality) {
            return ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              child: SeparatedColumn(
                separatorBuilder: () => const Gap(10),
                children: [
                  const Text(
                    'Selecione a qualidade do episodio',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Gap(10),
                  ...VideoQualityEnum.values.take(cubit.qualityLimit).map(
                        (e) => Button.secondary(
                          color: e == cubit.quality ? AppColors.pink_400 : null,
                          onPressed: () async => cubit.changeQuality(e),
                          child: Text('${e.name} - ${e.resolution}p'),
                        ).expandedH(),
                      ),
                ],
              ),
            );
          }
          return Container();
        },
      );
}
