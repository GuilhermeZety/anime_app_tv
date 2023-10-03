// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:anime_app_tv/app/core/shared/anime/domain/entities/episode/episode_entity.dart';

class EpisodeModel extends EpisodeEntity {
  const EpisodeModel({
    required super.uuid,
    required super.videoUuid,
    required super.episode,
    super.image,
    super.duration,
    super.uploadDate,
    super.name,
  });

  EpisodeModel copyWith({
    String? uuid,
    String? videoUuid,
    String? image,
    String? name,
    String? duration,
    String? uploadDate,
    int? episode,
    int? quality,
  }) {
    return EpisodeModel(
      uuid: uuid ?? this.uuid,
      videoUuid: videoUuid ?? this.videoUuid,
      image: image ?? this.image,
      name: name ?? this.name,
      episode: episode ?? this.episode,
      uploadDate: uploadDate ?? this.uploadDate,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'videoUuid': videoUuid,
      'image': image,
      'name': name,
      'episode': episode,
      'uploadDate': uploadDate,
      'duration': duration,
    };
  }

  factory EpisodeModel.fromMap(Map<String, dynamic> map) {
    return EpisodeModel(
      uuid: map['uuid'] as String,
      videoUuid: map['videoUuid'] as String?,
      image: map['image'] != null ? map['image'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      duration: map['duration'] != null ? map['duration'] as String : null,
      uploadDate: map['uploadDate'] != null ? map['uploadDate'] as String : null,
      episode: map['episode'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory EpisodeModel.fromJson(String source) => EpisodeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
