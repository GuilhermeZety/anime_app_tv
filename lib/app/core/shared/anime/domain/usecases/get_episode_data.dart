import 'package:anime_app_tv/app/core/common/errors/failures.dart';
import 'package:anime_app_tv/app/core/common/features/usecases/usecase.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/episode/episode_data_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/episode/episode_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/repositories/anime_repository.dart';
import 'package:dartz/dartz.dart';

class GetEpisodeData extends Usecase<EpisodeDataEntity, GetEpisodeDataParams> {
  final AnimeRepository repository;

  GetEpisodeData({
    required this.repository,
  });

  @override
  Future<Either<Failure, EpisodeDataEntity>> call(
    GetEpisodeDataParams params,
  ) async {
    return await repository.getEpisodeData(params.episode);
  }
}

class GetEpisodeDataParams {
  final EpisodeEntity episode;

  GetEpisodeDataParams({
    required this.episode,
  });
}
