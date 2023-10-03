import 'package:anime_app_tv/app/core/common/errors/failures.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_data_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/calendar_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/episode/episode_data_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/episode/episode_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AnimeRepository {
  Future<Either<Failure, List<AnimeEntity>>> search(String value);
  Future<Either<Failure, EpisodeDataEntity>> getEpisodeData(EpisodeEntity episode);
  Future<Either<Failure, AnimeDataEntity>> getAnimeData(AnimeEntity anime, int page);
  Future<Either<Failure, CalendarEntity>> getCalendar();
  Future<Either<Failure, Stream<List<EpisodeEntity>>>> getReleases();
}
