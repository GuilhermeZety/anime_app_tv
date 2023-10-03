// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app_tv/app/core/common/enums/anime_status_enum.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/episode/episode_entity.dart';
import 'package:equatable/equatable.dart';

abstract class AnimeDataEntity extends Equatable {
  final String genders;
  final AnimeStatus status;
  final String season;
  final String sinopsis;
  final bool dublado;
  final int page;
  final List<EpisodeEntity> episodes;
  final List<int> pages;

  const AnimeDataEntity({
    required this.genders,
    required this.status,
    required this.season,
    required this.page,
    required this.sinopsis,
    required this.episodes,
    required this.pages,
    required this.dublado,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      genders,
      status,
      season,
      sinopsis,
      episodes,
      pages,
      dublado,
    ];
  }
}
