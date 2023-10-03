part of 'watch_anime_cubit.dart';

sealed class WatchAnimeState extends Equatable {
  const WatchAnimeState();

  @override
  List<Object> get props => [];
}

final class WatchAnimeSelectQuality extends WatchAnimeState {}

final class WatchAnimeLoading extends WatchAnimeState {}

final class WatchAnimeStt extends WatchAnimeState {}
