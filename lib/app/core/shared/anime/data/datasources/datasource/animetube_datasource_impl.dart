import 'package:anime_app_tv/app/core/common/enums/anime_status_enum.dart';
import 'package:anime_app_tv/app/core/common/enums/video_quality_enum.dart';
import 'package:anime_app_tv/app/core/common/integrations/integration.dart';
import 'package:anime_app_tv/app/core/common/services/requests/request_service.dart';
import 'package:anime_app_tv/app/core/common/utils/utils.dart';
import 'package:anime_app_tv/app/core/shared/anime/data/datasources/datasource/anime_datasource.dart';
import 'package:anime_app_tv/app/core/shared/anime/data/models/anime/anime_data_model.dart';
import 'package:anime_app_tv/app/core/shared/anime/data/models/anime/anime_model.dart';
import 'package:anime_app_tv/app/core/shared/anime/data/models/calendar_item_model.dart';
import 'package:anime_app_tv/app/core/shared/anime/data/models/episode/episode_data_model.dart';
import 'package:anime_app_tv/app/core/shared/anime/data/models/episode/episode_model.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/episode/episode_entity.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

class AnimetubeDatasourceImpl extends AnimeDatasource {
  final RequestService requestService;
  final Integration integration;

  AnimetubeDatasourceImpl({
    required this.requestService,
    required this.integration,
  });

  @override
  Future<List<AnimeModel>> search(String value) async {
    final response = await requestService.get(
      integration.search(value),
    );

    if (response.data != null && response.data is String) {
      List<AnimeModel> animes = [];
      var document = parse(response.data);

      var list = document.querySelectorAll('.ani_loop_item');

      for (var anime in list) {
        var name = anime.querySelector('.ani_loop_item_infos_nome');
        var uuid = name?.attributes['href']?.split('/').last;
        var image = anime.querySelector('.ani_loop_item_img img')?.attributes['src'];

        animes.add(AnimeModel(uuid: uuid ?? 'not_found', image: image, name: name?.text));
      }
      return animes;
    }
    return [];
  }

  @override
  Future<EpisodeDataModel> getEpisodeData(EpisodeEntity episode) async {
    final response = await requestService.get(
      integration.episodeData(episode.uuid),
    );

    if (response.data != null && response.data is String) {
      var document = parse(response.data);
      VideoQualityEnum quality;

      var list = document.querySelectorAll('.abaItem');
      var urlSplitted = (document.querySelectorAll('[itemprop="contentURL"]').first.attributes['content'] ?? '').split('/');

      var identifier = urlSplitted[urlSplitted.length - 2];

      if (list.length == 1 || list.isEmpty) {
        quality = VideoQualityEnum.sd;
      } else if (list.length == 2) {
        quality = VideoQualityEnum.hd;
      } else {
        quality = VideoQualityEnum.fullhd;
      }

      var controllers = document.querySelector('.controles_ep');

      // if (controllers != null) {
      var next = controllers?.children.where((element) => element.text.contains('Próximo')).firstOrNull;
      var previous = controllers?.children.where((element) => element.text.contains('Anterior')).firstOrNull;

      var nextUUID = next?.attributes['href']?.split('/').last;
      var previousUUID = previous?.attributes['href']?.split('/').last;
      // }
      return EpisodeDataModel(
        quality: quality,
        uuid: episode.uuid,
        videoUuid: episode.videoUuid,
        name: episode.name,
        containsTwo: identifier.contains('2'),
        nextEpisodeUuid: nextUUID,
        previousEpisodeUuid: previousUUID,
      );
    }

    throw Exception('Erro ao buscar o calendario');
  }

  @override
  Future<AnimeDataModel> getAnimeData(AnimeEntity anime, int page) async {
    bool dublado = anime.name?.toLowerCase().contains('dublado') == true;
    final response = await requestService.get(
      integration.animeData(anime.uuid, dublado, page),
    );
    if (response.data != null && response.data is String) {
      var document = parse(response.data);

      var infos = document.querySelectorAll('.anime_info');

      var gender = infos
              .where((e) => e.querySelector('b')?.text.contains('Gêneros') == true)
              .firstOrNull
              ?.querySelectorAll('a')
              .map(
                (e) => e.text,
              )
              .toList()
              .join(', ') ??
          '';

      var stats = (infos.where((e) => e.querySelector('b')?.text.contains('Status') == true).firstOrNull?.text.contains('Em Progresso') ?? false) ? AnimeStatus.inProgress : AnimeStatus.completed;

      var season = infos.where((e) => e.querySelector('b')?.text.contains('Temporada') == true).firstOrNull?.querySelector('a')?.text ?? '';

      List<EpisodeModel> episodes = [];

      var list = document.querySelectorAll('.animepag_episodios_item');

      for (var ep in list) {
        var image = ep.querySelector('img');
        var imageURL = image?.attributes['src']?.split('/') ?? [];
        var videoUuid = imageURL[imageURL.length - 2];
        var uuid = ep.querySelector('a')?.attributes['href']?.split('/').last ?? '';

        var date = ep.querySelector('.animepag_episodios_item_date')?.text;
        var duration = ep.querySelector('.animepag_episodios_item_time')?.text;

        var episode = ep.querySelector('.animepag_episodios_item_views')?.text;

        episodes.add(
          EpisodeModel(
            uuid: uuid,
            videoUuid: videoUuid,
            episode: episode != null ? Utils.extractInt(episode) ?? 0 : 0,
            duration: duration,
            uploadDate: date,
            name: image?.attributes['title'],
            image: image?.attributes['src'],
          ),
        );
      }

      List<int> pages = [];

      var pagination = document.querySelector('.pagination');

      if (pagination != null) {
        var items = pagination.querySelectorAll('a');

        for (var item in items) {
          var page = Utils.extractInt(item.text);
          if (page != null) {
            pages.add(page);
          }
        }
      }

      return AnimeDataModel(
        dublado: dublado,
        genders: gender,
        page: page,
        status: stats,
        season: season,
        sinopsis: document.querySelector('.sinopse_container_content')?.text ?? '',
        episodes: episodes,
        pages: pages,
      );
    }

    throw Exception('Erro ao buscar o calendario');
  }

  @override
  Future<CalendarModel> getCalendar() async {
    final response = await requestService.get(
      integration.calendar,
    );
    if (response.data != null && response.data is String) {
      var document = parse(response.data);

      return CalendarModel(
        sunday: _getListCalendarItem(document.querySelectorAll('#p1 .ani_loop_item')),
        monday: _getListCalendarItem(document.querySelectorAll('#p2 .ani_loop_item')),
        tuesday: _getListCalendarItem(document.querySelectorAll('#p3 .ani_loop_item')),
        wednesday: _getListCalendarItem(document.querySelectorAll('#p4 .ani_loop_item')),
        thursday: _getListCalendarItem(document.querySelectorAll('#p5 .ani_loop_item')),
        friday: _getListCalendarItem(document.querySelectorAll('#p6 .ani_loop_item')),
        saturday: _getListCalendarItem(document.querySelectorAll('#p7 .ani_loop_item')),
        undefined: _getListCalendarItem(document.querySelectorAll('#p8 .ani_loop_item')),
      );
    }

    throw Exception('Erro ao buscar o calendario');
  }

  List<CalendarAnimeModel> _getListCalendarItem(List<Element> elements) {
    List<CalendarAnimeModel> items = [];
    for (var anime in elements) {
      var name = anime.querySelector('.ani_loop_item_infos_nome');
      var image = anime.querySelector('.ani_loop_item_img img');
      var type = anime.querySelector('.epi_loop_img_data');
      var date = anime.querySelector('.epi_loop_img_time');
      var uuid = '';

      var a = anime.querySelector('a');
      if (a != null) {
        uuid = a.attributes['href']?.split('/').last ?? '';
      }

      items.add(
        CalendarAnimeModel(
          uuid: uuid,
          image: image?.attributes['src'],
          name: name?.text ?? '',
          type: type?.text,
          date: date?.text,
        ),
      );
    }
    return items;
  }

  @override
  Future<List<EpisodeModel>> getReleases() async {
    final response = await requestService.get(
      integration.releases,
    );

    if (response.data != null && response.data is String) {
      List<EpisodeModel> episodes = [];
      var document = parse(response.data);

      var list = document.querySelectorAll('.mContainer');

      if (list.isEmpty) return [];

      var release = list
          .where(
            (element) => element.querySelector('.mContainer_titulo_content')?.text.contains('Lançamentos') == true,
          )
          .firstOrNull;

      if (release == null) return [];

      var items = release.querySelectorAll('.epi_loop_item');

      for (var ep in items) {
        var image = ep.querySelector('img');
        var imageURL = image?.attributes['src']?.split('/') ?? [];
        var uuid = imageURL[imageURL.length - 2];

        var date = ep.querySelector('.epi_loop_img_data');
        var duration = ep.querySelector('.epi_loop_img_time');

        var episode = ep.querySelector('.epi_loop_nome_sub')?.text;

        episodes.add(
          EpisodeModel(
            uuid: uuid,
            videoUuid: uuid,
            episode: episode != null ? Utils.extractInt(episode) ?? 0 : 0,
            duration: duration?.text,
            uploadDate: date?.text,
            name: image?.attributes['title'],
            image: image?.attributes['src'],
          ),
        );
      }
      return episodes;
    }
    return [];
  }
}
