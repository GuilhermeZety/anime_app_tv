import 'dart:convert';

import 'package:anime_app_tv/app/core/common/extensions/entities_extension.dart';
import 'package:anime_app_tv/app/core/shared/anime/data/datasources/datasource/animetube_datasource_impl.dart';
import 'package:anime_app_tv/app/core/shared/anime/data/models/anime/anime_model.dart';
import 'package:anime_app_tv/app/core/shared/anime/data/models/episode/episode_model.dart';
import 'package:anime_app_tv/app/core/shared/anime/data/repositories/anime_repository_impl.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/episode/episode_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/repositories/anime_repository.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/usecases/get_anime_data.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/usecases/get_calendar.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/usecases/get_episode_data.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/usecases/get_releases.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/usecases/search_anime.dart';
import 'package:anime_app_tv/main.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AnimeLogic {
  static void binds(Injector i) {
    i.addLazySingleton<AnimeRepository>(
      () => AnimeRepositoryImpl(
        datasource: AnimetubeDatasourceImpl(
          requestService: i.get(),
          integration: i.get(),
        ),
      ),
    );
    i.addLazySingleton<SearchAnime>(
      () => SearchAnime(
        repository: i.get<AnimeRepository>(),
      ),
    );
    i.addLazySingleton<GetReleases>(
      () => GetReleases(
        repository: i.get<AnimeRepository>(),
      ),
    );
    i.addLazySingleton<GetCalendar>(
      () => GetCalendar(
        repository: i.get<AnimeRepository>(),
      ),
    );
    i.addLazySingleton<GetEpisodeData>(
      () => GetEpisodeData(
        repository: i.get<AnimeRepository>(),
      ),
    );
    i.addLazySingleton<GetAnimeData>(
      () => GetAnimeData(
        repository: i.get<AnimeRepository>(),
      ),
    );
  }

  static const String key = 'favorite_anime';
  static const String releasesKey = 'releases';
  static const String watchedAnime = 'watchedAnime';

  static List<AnimeEntity> getAllFavoriteAnime() {
    var response = session.prefs.getStringList(key);

    if (response == null) return [];

    var map = response.map((e) => AnimeModel.fromJson(e)).toList();

    return map;
  }

  static AnimeEntity? getFavoriteAnime(String uuid) {
    var response = session.prefs.getStringList(key);

    if (response == null) return null;

    var map = response.map((e) => AnimeModel.fromJson(e)).toList();

    return map.where((element) => element.uuid == uuid).firstOrNull;
  }

  static Future<void> setFavoriteAnime(AnimeEntity anime) async {
    var favorited = getFavoriteAnime(anime.uuid);

    if (favorited != null) {
      var all = getAllFavoriteAnime();

      all.removeWhere((element) => element.uuid == anime.uuid);

      await session.prefs.setStringList(
        key,
        all.map((e) => e.as<AnimeModel>().toJson()).toList(),
      );
    } else {
      var all = getAllFavoriteAnime();

      all.add(anime);

      await session.prefs.setStringList(
        key,
        all.map((e) => e.as<AnimeModel>().toJson()).toList(),
      );
    }
  }

  static Future<void> setAllReleases(List<EpisodeEntity> releases) async {
    await session.prefs.setStringList(
      releasesKey,
      releases.map((e) => e.as<EpisodeModel>().toJson()).toList(),
    );
  }

  static List<EpisodeModel> getAllReleases() {
    var response = session.prefs.getStringList(releasesKey);

    if (response == null) return [];

    var map = response.map((e) => EpisodeModel.fromJson(e)).toList();

    return map;
  }

  static Future<void> setWatchEps({required EpisodeEntity episode, required AnimeEntity anime, required int page}) async {
    var eps = getAnimeWatchEps(anime.uuid);
    eps.removeWhere((element) => element['ep'] == episode.uuid);
    eps.add({
      'anime': anime.uuid,
      'ep': episode.uuid,
      'page': page,
    });

    await session.prefs.setStringList(
      anime.uuid,
      eps.map((e) => jsonEncode(e)).toList(),
    );
  }

  static List<Map<String, dynamic>> getAnimeWatchEps(String uuidAnime) {
    var response = session.prefs.getStringList(uuidAnime);

    if (response == null) return [];

    return response.map<Map<String, dynamic>>((e) => jsonDecode(e)).toList();
  }
}
