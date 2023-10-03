// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_entity.dart';

class AnimeModel extends AnimeEntity {
  AnimeModel({required super.uuid, required super.image, required super.name});

  AnimeModel copyWith({
    String? uuid,
    String? image,
    String? name,
  }) {
    return AnimeModel(
      uuid: uuid ?? this.uuid,
      image: image ?? this.image,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'image': image,
      'name': name,
    };
  }

  factory AnimeModel.fromMap(Map<String, dynamic> map) {
    return AnimeModel(
      uuid: map['uuid'] as String,
      image: map['image'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnimeModel.fromJson(String source) => AnimeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
