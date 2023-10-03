// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_data_entity.dart';

class AnimeDataModel extends AnimeDataEntity {
  const AnimeDataModel({
    required super.genders,
    required super.status,
    required super.page,
    required super.season,
    required super.sinopsis,
    required super.episodes,
    required super.pages,
    required super.dublado,
  });
}
