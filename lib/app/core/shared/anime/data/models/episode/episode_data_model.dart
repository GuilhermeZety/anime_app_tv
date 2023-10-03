// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/episode/episode_data_entity.dart';

class EpisodeDataModel extends EpisodeDataEntity {
  const EpisodeDataModel({
    required super.quality,
    required super.uuid,
    super.videoUuid,
    super.name,
    super.containsTwo,
    super.nextEpisodeUuid,
    super.previousEpisodeUuid,
  });
}
