// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class EpisodeEntity extends Equatable {
  final String uuid;
  final String? videoUuid;
  final String? image;
  final String? name;
  final int episode;
  final String? uploadDate;
  final String? duration;

  /// 0 - 480p, 1 - 720p, 2 - 1080p
  // final int quality;

  const EpisodeEntity({
    required this.uuid,
    required this.videoUuid,
    this.image,
    this.name,
    this.uploadDate,
    this.duration,
    required this.episode,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      uuid,
      image,
      name,
      uploadDate,
      duration,
      episode,
    ];
  }
}
