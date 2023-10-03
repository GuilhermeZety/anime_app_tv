import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:anime_app_tv/app/core/common/constants/app_routes.dart';
import 'package:anime_app_tv/app/core/common/extensions/context_extension.dart';
import 'package:anime_app_tv/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app_tv/app/core/shared/anime/presentation/components/anime_item.dart';
import 'package:anime_app_tv/app/core/shared/anime/presentation/components/episode_item.dart';
import 'package:anime_app_tv/app/modules/home/presentation/pages/initial/cubit/initial_cubit.dart';
import 'package:anime_app_tv/app/ui/components/input.dart';
import 'package:anime_app_tv/app/ui/components/shimed_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  TextEditingController controller = TextEditingController();

  final InitialCubit _cubit = Modular.get<InitialCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _cubit,
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            await _cubit.refresh();
          },
          backgroundColor: AppColors.pink_400,
          color: AppColors.grey_600,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildSearch(),
              _buildTitle(),
              _buildAnimes(),
              ..._buildReleases(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearch() {
    return SliverAppBar(
      pinned: true,
      floating: true,
      leading: const SizedBox(),
      backgroundColor: AppColors.grey_700.withOpacity(0.5),
      elevation: 0,
      expandedHeight: 90,
      collapsedHeight: 90,
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Input(
              controller,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 20, right: 10),
                child: Icon(Icons.search_rounded),
              ),
              onSubmit: (_) => Modular.to.pushNamed(AppRoutes.search, arguments: controller),
              hint: 'Insira o nome do anime',
            ).hero('search'),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildReleases() {
    var qtd = ((context.width - 40) / (context.isLandscape ? 250 : 210)).floor().abs();
    if (qtd > 6) {
      qtd = 6;
    }
    if (qtd == 0) {
      qtd = 1;
    }
    return [
      SliverPadding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 10, top: 20),
        sliver: SliverList.list(
          children: const [
            Text(
              '🔥 Lançamentos',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
        sliver: SliverGrid.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: qtd,
          childAspectRatio: context.isLandscape ? 1.1 / 1 : 1.3 / 1,
          children: [
            if (_cubit.releasesLoading)
              ...List.generate(
                qtd * 3,
                (index) => const ShimmedBox(),
              )
            else
              ..._cubit.releases
                  .map(
                    (e) => EpisodeItem(episode: e).animate().fade(),
                  )
                  .toList(),
          ],
        ),
      ),
    ];
  }

  Widget _buildTitle() => SliverPadding(
        padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 20),
        sliver: SliverList.list(
          children: const [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: AppColors.pink_400,
                      size: 20,
                    ),
                    Gap(5),
                    Text(
                      'Favoritos',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildAnimes() {
    var qtd = ((context.width - 40) / 150).floor().abs();
    if (qtd > 6) {
      qtd = 6;
    }
    if (qtd == 0) {
      qtd = 1;
    }
    return SliverPadding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 0),
      sliver: SliverGrid.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: qtd,
        children: [
          // if (loading)
          //   ...List.generate(
          //     qtd * 3,
          //     (index) => const ShimmedBox(),
          //   )
          // else
          ..._cubit.animes
              .map(
                (e) => AnimeItem(anime: e),
              )
              .toList(),
        ],
      ),
    );
  }
}
