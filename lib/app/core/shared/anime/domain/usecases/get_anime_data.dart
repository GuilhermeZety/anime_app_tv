import 'package:anime_app_tv/app/core/common/errors/failures.dart';
import 'package:anime_app_tv/app/core/common/features/usecases/usecase.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_data_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/repositories/anime_repository.dart';
import 'package:dartz/dartz.dart';

class GetAnimeData extends Usecase<AnimeDataEntity, GetAnimeDataParams> {
  final AnimeRepository repository;

  GetAnimeData({
    required this.repository,
  });

  @override
  Future<Either<Failure, AnimeDataEntity>> call(
    GetAnimeDataParams params,
  ) async {
    return await repository.getAnimeData(params.anime, params.page);
  }
}

class GetAnimeDataParams {
  final AnimeEntity anime;
  final int page;

  GetAnimeDataParams({
    required this.anime,
    required this.page,
  });
}
