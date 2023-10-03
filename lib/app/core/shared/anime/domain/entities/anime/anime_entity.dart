// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class AnimeEntity implements Equatable {
  final String uuid;
  final String? image;
  final String? name;

  const AnimeEntity({
    required this.uuid,
    required this.image,
    required this.name,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [uuid, image, name];
}
