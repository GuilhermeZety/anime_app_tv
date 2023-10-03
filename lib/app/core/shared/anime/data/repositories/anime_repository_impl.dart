import 'package:anime_app_tv/app/core/common/errors/failures.dart';
import 'package:anime_app_tv/app/core/common/services/treater/treater_service.dart';
import 'package:anime_app_tv/app/core/shared/anime/anime_logic.dart';
import 'package:anime_app_tv/app/core/shared/anime/data/datasources/datasource/anime_datasource.dart';
import 'package:anime_app_tv/app/core/shared/anime/data/models/anime/anime_data_model.dart';
import 'package:anime_app_tv/app/core/shared/anime/data/models/anime/anime_model.dart';
import 'package:anime_app_tv/app/core/shared/anime/data/models/calendar_item_model.dart';
import 'package:anime_app_tv/app/core/shared/anime/data/models/episode/episode_data_model.dart';
import 'package:anime_app_tv/app/core/shared/anime/data/models/episode/episode_model.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/episode/episode_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/repositories/anime_repository.dart';
import 'package:dartz/dartz.dart';

class AnimeRepositoryImpl extends AnimeRepository {
  final AnimeDatasource datasource;

  AnimeRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Failure, List<AnimeModel>>> search(String value) {
    return TreaterService()<List<AnimeModel>>(
      () async {
        return await datasource.search(value);
      },
      errorIdentification: 'Erro ao buscar o anime',
    );
  }

  @override
  Future<Either<Failure, EpisodeDataModel>> getEpisodeData(EpisodeEntity episode) {
    return TreaterService()<EpisodeDataModel>(
      () async {
        return await datasource.getEpisodeData(episode);
      },
      errorIdentification: 'Erro ao buscar os dados do episodio',
    );
  }

  @override
  Future<Either<Failure, AnimeDataModel>> getAnimeData(AnimeEntity anime, int page) {
    return TreaterService()<AnimeDataModel>(
      () async {
        return await datasource.getAnimeData(anime, page);
      },
      errorIdentification: 'Erro ao buscar os dados do anime',
    );
  }

  @override
  Future<Either<Failure, CalendarModel>> getCalendar() {
    return TreaterService()<CalendarModel>(
      () async {
        return await datasource.getCalendar();
      },
      errorIdentification: 'Erro ao buscar o calendario',
    );
  }

  @override
  Future<Either<Failure, Stream<List<EpisodeModel>>>> getReleases() {
    return TreaterService()<Stream<List<EpisodeModel>>>(
      () async {
        return streamReleases();
      },
      errorIdentification: 'Erro ao buscar o lançamentos',
    );
  }

  Stream<List<EpisodeModel>> streamReleases() async* {
    var cachedReleases = AnimeLogic.getAllReleases();

    if (cachedReleases.isNotEmpty) {
      yield cachedReleases;
    }

    var releases = await datasource.getReleases();
    await AnimeLogic.setAllReleases(releases);

    yield releases;
  }
}
