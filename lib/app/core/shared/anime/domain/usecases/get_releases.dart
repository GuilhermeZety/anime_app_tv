import 'package:anime_app_tv/app/core/common/errors/failures.dart';
import 'package:anime_app_tv/app/core/common/features/usecases/usecase.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/episode/episode_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/repositories/anime_repository.dart';
import 'package:dartz/dartz.dart';

class GetReleases extends Usecase<Stream<List<EpisodeEntity>>, NoParams> {
  final AnimeRepository repository;

  GetReleases({
    required this.repository,
  });

  @override
  Future<Either<Failure, Stream<List<EpisodeEntity>>>> call(
    NoParams params,
  ) async {
    return await repository.getReleases();
  }
}
