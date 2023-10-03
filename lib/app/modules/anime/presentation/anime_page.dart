import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:anime_app_tv/app/core/common/extensions/context_extension.dart';
import 'package:anime_app_tv/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/presentation/components/episode_item.dart';
import 'package:anime_app_tv/app/modules/anime/presentation/cubit/anime_page_cubit.dart';
import 'package:anime_app_tv/app/ui/components/image_cached.dart';
import 'package:anime_app_tv/app/ui/components/panel.dart';
import 'package:anime_app_tv/app/ui/components/shimed_box.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({super.key, required this.anime});

  final AnimeEntity anime;

  @override
  State<AnimePage> createState() => _AnimePageState();
}

class _AnimePageState extends State<AnimePage> {
  AnimePageCubit cubit = AnimePageCubit();

  @override
  void initState() {
    cubit.init(widget.anime);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey_500,
      appBar: AppBar(
        backgroundColor: AppColors.grey_500,
        elevation: 0,
      ),
      body: BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1200,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Panel(
                        child: Column(
                          children: [
                            Builder(
                              builder: (context) {
                                if (context.isLandscape) {
                                  return Column(
                                    children: [
                                      Text(
                                        '${widget.anime.name}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Gap(10),
                                      Row(
                                        children: [
                                          _buildAnimeImage,
                                          const Gap(20),
                                          _buildAnimeInfo(state is AnimePageLoading).expanded(),
                                        ],
                                      ),
                                    ],
                                  );
                                }
                                return Column(
                                  children: [
                                    Text(
                                      '${widget.anime.name}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Gap(10),
                                    _buildAnimeImage,
                                    const Gap(20),
                                    Row(
                                      children: [
                                        _buildAnimeInfo(state is AnimePageLoading).expanded(),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                            if (context.isLandscape) ...[
                              const Gap(20),
                              Panel(
                                color: AppColors.grey_700,
                                child: _buildSinopisis(state is AnimePageLoading),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const Gap(20),
                      Panel(
                        child: Column(
                          children: [
                            _buildPagination(state is AnimePageLoading),
                            const Gap(20),
                            _buildGridAnimes(state is AnimePageLoading),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get _buildAnimeImage {
    return SizedBox(
      height: 200,
      width: 200,
      child: ImageCached(
        url: widget.anime.image ?? '',
        radius: 20,
      ).hero(widget.anime.uuid),
    );
  }

  Widget _buildAnimeInfo(bool loading) {
    if (loading) {
      return SeparatedColumn(
        separatorBuilder: () => const Gap(14),
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: const [
          ShimmedBox(
            height: 23,
            width: 160,
          ),
          ShimmedBox(
            height: 23,
            width: 140,
          ),
          ShimmedBox(
            height: 23,
            width: 300,
          ),
          ShimmedBox(
            height: 23,
            width: 80,
          ),
        ],
      );
    }
    var animedata = cubit.animeData!;
    return SeparatedColumn(
      separatorBuilder: () => const Divider(),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildItemData('Temporada', animedata.season),
        _buildItemData('Status', animedata.status.name, colorData: animedata.status.color),
        _buildItemData('Gêneros', animedata.genders),
        _buildItemData('Dublado', animedata.dublado ? 'Sim' : 'Não'),
      ],
    );
  }

  Widget _buildItemData(String title, String data, {Color? colorData}) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          data,
          style: TextStyle(color: colorData ?? AppColors.grey_200),
        ).expanded(),
      ],
    );
  }

  Widget _buildSinopisis(bool loading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sinopse',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(10),
        Builder(
          builder: (context) {
            if (loading) {
              return const ShimmedBox(
                height: 30,
              ).expandedH();
            }
            var animedata = cubit.animeData!;
            return Text(
              animedata.sinopsis,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.grey_200,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPagination(bool loading) {
    if (loading) {
      return const ShimmedBox(
        height: 30,
      ).expandedH();
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        children: [
          ...cubit.animeData!.pages.map(
            (e) => Padding(
              padding: const EdgeInsets.all(0),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () async => await cubit.getData(e),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: cubit.animeData!.page == e ? AppColors.pink_400 : AppColors.grey_700,
                    ),
                    child: Text(
                      '$e',
                      style: const TextStyle(
                        color: AppColors.grey_200,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridAnimes(bool loading) {
    var qtd = ((context.width - 40) / 150).floor().abs();
    if (qtd > 6) {
      qtd = 6;
    }
    if (qtd == 0) {
      qtd = 1;
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: qtd,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.9,
      ),
      itemCount: cubit.animeData?.episodes.length ?? qtd * 3,
      itemBuilder: (_, index) => loading
          ? const ShimmedBox()
          : EpisodeItem(
              episode: cubit.animeData!.episodes[index],
              anime: widget.anime,
              page: cubit.animeData!.page,
            ),
    );
  }
}
