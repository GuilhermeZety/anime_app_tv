part of 'anime_page_cubit.dart';

sealed class AnimePageState extends Equatable {
  const AnimePageState();

  @override
  List<Object> get props => [];
}

final class AnimePageInitial extends AnimePageState {}

final class AnimePageLoading extends AnimePageState {}

final class AnimePageLoaded extends AnimePageState {}
