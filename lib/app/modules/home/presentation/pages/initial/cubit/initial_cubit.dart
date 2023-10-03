import 'dart:async';

import 'package:anime_app_tv/app/core/common/features/usecases/usecase.dart';
import 'package:anime_app_tv/app/core/shared/anime/anime_logic.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/episode/episode_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/usecases/get_releases.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'initial_state.dart';

class InitialCubit extends Cubit<InitialState> {
  InitialCubit() : super(InitialInitial());

  bool releasesLoading = true;

  List<EpisodeEntity> releases = [];
  List<AnimeEntity> animes = [];

  StreamSubscription? _streamSubscriptionReleases;

  Future init() async {
    await getReleases();
    await loadAnimes();
  }

  Future refresh() async {
    _streamSubscriptionReleases?.cancel();
    releases = [];

    await getReleases();
  }

  Future getReleases() async {
    if (releases.isEmpty) {
      releasesLoading = true;
      setState();
    }
    var stream = await Modular.get<GetReleases>()(NoParams()).then(
      (value) => value.fold(
        (l) => const Stream<List<EpisodeEntity>>.empty(),
        (r) => r,
      ),
    );

    _streamSubscriptionReleases = stream.listen((event) {
      releases = event;
      releasesLoading = false;
      setState();
    });
  }

  void setState() {
    if (state is InitialSetState) {
      emit(InitialSetState());
    } else {
      emit(InitialInitial());
      emit(InitialSetState());
    }
    emit(InitialInitial());
  }

  Future loadAnimes() async {
    animes = AnimeLogic.getAllFavoriteAnime();
    setState();
  }
}
