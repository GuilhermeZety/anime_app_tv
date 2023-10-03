import 'dart:developer';

import 'package:anime_app_tv/app/core/common/constants/app_colors.dart';
import 'package:anime_app_tv/app/core/common/extensions/context_extension.dart';
import 'package:anime_app_tv/app/core/common/extensions/widget_extension.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/usecases/search_anime.dart';
import 'package:anime_app_tv/app/core/shared/anime/presentation/components/anime_item.dart';
import 'package:anime_app_tv/app/ui/components/input_search.dart';
import 'package:anime_app_tv/app/ui/components/shimed_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:gap/gap.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<AnimeEntity> animes = [];
  bool loading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await search();
    });
    super.initState();
  }

  Future search() async {
    loading = true;
    if (mounted) setState(() {});
    var response = await Modular.get<SearchAnime>()(SearchAnimeParams(value: widget.controller.text));

    response.fold((l) {
      log(l.toString());
    }, (r) {
      animes = r;
    });
    loading = false;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: AppColors.backgrondGradient,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildSearch(),
              if (animes.isNotEmpty || loading == true) _buildAnimes() else _buildNoResults(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoResults() => SliverPadding(
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 20, top: context.height * 0.4),
        sliver: SliverList.list(
          children: const [
            Center(
              child: Text(
                'Nenhum resultado encontrado',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.grey_200,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildSearch() {
    return SliverAppBar(
      pinned: true,
      floating: true,
      leading: const SizedBox(),
      backgroundColor: AppColors.grey_700.withOpacity(0.5),
      elevation: 0,
      expandedHeight: 100,
      collapsedHeight: 100,
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  color: AppColors.grey_200,
                  onPressed: () => Modular.to.pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
                const Gap(20),
                InputSearch(
                  widget.controller,
                  searchAction: (_) async {
                    await search();
                  },
                  hint: 'Insira o nome do anime',
                  prefixIcon: const Icon(Icons.search),
                ).hero('search').expanded(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimes() {
    var qtd = ((context.width - 40) / 150).floor().abs();
    if (qtd > 6) {
      qtd = 6;
    }
    if (qtd == 0) {
      qtd = 1;
    }
    return SliverPadding(
      padding: const EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 20),
      sliver: SliverGrid.count(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: qtd,
        children: [
          if (loading)
            ...List.generate(
              qtd * 3,
              (index) => const ShimmedBox(),
            )
          else
            ...animes
                .map(
                  (e) => AnimeItem(anime: e).animate().fade(),
                )
                .toList(),
        ],
      ),
    );
  }
}
