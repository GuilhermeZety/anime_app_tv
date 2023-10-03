// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:anime_app_tv/app/core/shared/anime/data/models/anime/anime_model.dart';
import 'package:equatable/equatable.dart';

abstract class CalendarEntity extends Equatable {
  final List<CalendarAnimeEntity> sunday;
  final List<CalendarAnimeEntity> monday;
  final List<CalendarAnimeEntity> tuesday;
  final List<CalendarAnimeEntity> wednesday;
  final List<CalendarAnimeEntity> thursday;
  final List<CalendarAnimeEntity> friday;
  final List<CalendarAnimeEntity> saturday;
  final List<CalendarAnimeEntity> undefined;

  const CalendarEntity({
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.undefined,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      sunday,
      monday,
      tuesday,
      wednesday,
      thursday,
      friday,
      saturday,
      undefined,
    ];
  }
}

abstract class CalendarAnimeEntity extends Equatable {
  final String uuid;
  final String name;
  final String? image;
  final String? type;
  final String? date;

  const CalendarAnimeEntity({
    required this.uuid,
    required this.name,
    this.image,
    this.type,
    this.date,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      uuid,
      name,
      image,
      type,
      date,
    ];
  }
}

extension ToAnime on CalendarAnimeEntity {
  AnimeModel toAnime() {
    return AnimeModel(
      uuid: uuid,
      name: name,
      image: image,
    );
  }
}
