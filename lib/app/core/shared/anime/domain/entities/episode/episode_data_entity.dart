// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app_tv/app/core/common/enums/video_quality_enum.dart';
import 'package:equatable/equatable.dart';

abstract class EpisodeDataEntity extends Equatable {
  final String uuid;
  final String? videoUuid;
  final String? name;
  final VideoQualityEnum quality;
  final bool? containsTwo;
  final String? nextEpisodeUuid;
  final String? previousEpisodeUuid;

  const EpisodeDataEntity({
    required this.uuid,
    required this.videoUuid,
    required this.name,
    required this.quality,
    this.containsTwo,
    this.nextEpisodeUuid,
    this.previousEpisodeUuid,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [quality];
}
