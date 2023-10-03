import 'package:anime_app_tv/app/core/common/errors/failures.dart';
import 'package:anime_app_tv/app/core/common/features/usecases/usecase.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/repositories/anime_repository.dart';
import 'package:dartz/dartz.dart';

class SearchAnime extends Usecase<List<AnimeEntity>, SearchAnimeParams> {
  final AnimeRepository repository;

  SearchAnime({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<AnimeEntity>>> call(
    SearchAnimeParams params,
  ) async {
    return await repository.search(params.value);
  }
}

class SearchAnimeParams {
  final String value;

  SearchAnimeParams({
    required this.value,
  });
}
