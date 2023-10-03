import 'dart:developer';

import 'package:anime_app_tv/app/core/shared/anime/anime_logic.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_data_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/usecases/get_anime_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'anime_page_state.dart';

class AnimePageCubit extends Cubit<AnimePageState> {
  AnimePageCubit() : super(AnimePageInitial());

  AnimeEntity? anime;
  AnimeDataEntity? animeData;

  Future init(AnimeEntity anim) async {
    var list = AnimeLogic.getAnimeWatchEps(anim.uuid);
    anime = anim;
    await getData(list.isNotEmpty == true ? list.last['page'] ?? 1 : 1);
    log(animeData?.genders ?? '');
  }

  Future getData(int page) async {
    emit(AnimePageLoading());
    animeData = await Modular.get<GetAnimeData>()(GetAnimeDataParams(anime: anime!, page: page)).then((value) => value.fold((l) => null, (r) => r));
    emit(AnimePageLoaded());
  }
}
