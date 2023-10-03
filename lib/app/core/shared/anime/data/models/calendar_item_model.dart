// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:anime_app_tv/app/core/common/extensions/entities_extension.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/calendar_entity.dart';

class CalendarModel extends CalendarEntity {
  const CalendarModel({
    required super.sunday,
    required super.monday,
    required super.tuesday,
    required super.wednesday,
    required super.thursday,
    required super.friday,
    required super.saturday,
    required super.undefined,
  });
  CalendarModel copyWith({
    List<CalendarAnimeEntity>? sunday,
    List<CalendarAnimeEntity>? monday,
    List<CalendarAnimeEntity>? tuesday,
    List<CalendarAnimeEntity>? wednesday,
    List<CalendarAnimeEntity>? thursday,
    List<CalendarAnimeEntity>? friday,
    List<CalendarAnimeEntity>? saturday,
    List<CalendarAnimeEntity>? undefined,
  }) {
    return CalendarModel(
      sunday: sunday ?? this.sunday,
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
      undefined: undefined ?? this.undefined,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sunday': sunday.map((x) => x.as<CalendarAnimeModel>().toMap()).toList(),
      'monday': monday.map((x) => x.as<CalendarAnimeModel>().toMap()).toList(),
      'tuesday': tuesday.map((x) => x.as<CalendarAnimeModel>().toMap()).toList(),
      'wednesday': wednesday.map((x) => x.as<CalendarAnimeModel>().toMap()).toList(),
      'thursday': thursday.map((x) => x.as<CalendarAnimeModel>().toMap()).toList(),
      'friday': friday.map((x) => x.as<CalendarAnimeModel>().toMap()).toList(),
      'saturday': saturday.map((x) => x.as<CalendarAnimeModel>().toMap()).toList(),
      'undefined': undefined.map((x) => x.as<CalendarAnimeModel>().toMap()).toList(),
    };
  }

  factory CalendarModel.fromMap(Map<String, dynamic> map) {
    return CalendarModel(
      sunday: map['sunday']?.map<CalendarAnimeEntity>(
            (x) => CalendarAnimeModel.fromMap(x as Map<String, dynamic>),
          ) ??
          [],
      monday: map['monday']?.map<CalendarAnimeEntity>(
            (x) => CalendarAnimeModel.fromMap(x as Map<String, dynamic>),
          ) ??
          [],
      tuesday: map['tuesday']?.map<CalendarAnimeEntity>(
            (x) => CalendarAnimeModel.fromMap(x as Map<String, dynamic>),
          ) ??
          [],
      wednesday: map['wednesday']?.map<CalendarAnimeEntity>(
            (x) => CalendarAnimeModel.fromMap(x as Map<String, dynamic>),
          ) ??
          [],
      thursday: map['thursday']?.map<CalendarAnimeEntity>(
            (x) => CalendarAnimeModel.fromMap(x as Map<String, dynamic>),
          ) ??
          [],
      friday: map['friday']?.map<CalendarAnimeEntity>(
            (x) => CalendarAnimeModel.fromMap(x as Map<String, dynamic>),
          ) ??
          [],
      saturday: map['saturday']?.map<CalendarAnimeEntity>(
            (x) => CalendarAnimeModel.fromMap(x as Map<String, dynamic>),
          ) ??
          [],
      undefined: map['undefined']?.map<CalendarAnimeEntity>(
            (x) => CalendarAnimeModel.fromMap(x as Map<String, dynamic>),
          ) ??
          [],
    );
  }

  String toJson() => json.encode(toMap());

  factory CalendarModel.fromJson(String source) => CalendarModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class CalendarAnimeModel extends CalendarAnimeEntity {
  const CalendarAnimeModel({required super.uuid, required super.name, super.image, super.type, super.date});

  CalendarAnimeModel copyWith({
    String? uuid,
    String? name,
    String? image,
    String? type,
    String? date,
  }) {
    return CalendarAnimeModel(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      image: image ?? this.image,
      type: type ?? this.type,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'name': name,
      'image': image,
      'type': type,
      'date': date,
    };
  }

  factory CalendarAnimeModel.fromMap(Map<String, dynamic> map) {
    return CalendarAnimeModel(
      uuid: map['uuid'] as String,
      name: map['name'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CalendarAnimeModel.fromJson(String source) => CalendarAnimeModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}
