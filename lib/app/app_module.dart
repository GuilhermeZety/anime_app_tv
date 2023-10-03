import 'package:anime_app_tv/app/core/common/integrations/animetube.dart';
import 'package:anime_app_tv/app/core/common/integrations/integration.dart';
import 'package:anime_app_tv/app/core/common/services/connection/connection_checker_plus_service_impl.dart';
import 'package:anime_app_tv/app/core/common/services/connection/connection_service.dart';
import 'package:anime_app_tv/app/core/common/services/requests/dio_request_service.dart';
import 'package:anime_app_tv/app/core/common/services/requests/request_service.dart';
import 'package:anime_app_tv/app/core/common/utils/toasting.dart';
import 'package:anime_app_tv/app/core/shared/anime/anime_logic.dart';
import 'package:anime_app_tv/app/core/shared/anime/domain/entities/anime/anime_entity.dart';
import 'package:anime_app_tv/app/modules/anime/presentation/anime_page.dart';
import 'package:anime_app_tv/app/modules/home/home_module.dart';
import 'package:anime_app_tv/app/modules/not_connection/presenter/not_connection_page.dart';
import 'package:anime_app_tv/app/modules/search/presentation/pages/search_page.dart';
import 'package:anime_app_tv/app/modules/splash/presentation/pages/splash_page.dart';
import 'package:anime_app_tv/app/modules/watch/presentation/watch_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(Injector i) {
    i.addSingleton<ConnectionService>(() => ConnectionCheckerPlusServiceImpl());
    i.addSingleton<RequestService>(() => DioRequestService());
    i.addSingleton<Integration>(() => Anitube());
    AnimeLogic.binds(i);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (args) => const SplashPage(),
      transition: TransitionType.fadeIn,
    );
    r.child(
      '/search/',
      child: (args) {
        if (r.args.data == null || r.args.data is! TextEditingController) {
          Toasting.warning(args, message: 'Erro ao pesquisar');
          return const SizedBox();
        }
        return SearchPage(
          controller: r.args.data as TextEditingController,
        );
      },
      transition: TransitionType.fadeIn,
    );
    r.child(
      '/anime/',
      child: (args) {
        if (r.args.data == null || r.args.data is! AnimeEntity) {
          Toasting.warning(args, message: 'Erro ao obter dados do anime');
          return const SizedBox();
        }
        return AnimePage(
          anime: r.args.data as AnimeEntity,
        );
      },
      transition: TransitionType.fadeIn,
    );
    r.child(
      '/watch/',
      child: (args) {
        if (r.args.data == null || r.args.data is! List) {
          Toasting.warning(args, message: 'Erro ao assistir anime');
          Modular.to.pop();
          return const SizedBox();
        }
        return WatchPage(
          episodeData: r.args.data[0],
          quality: r.args.data[1],
          anime: r.args.data[2],
        );
      },
      transition: TransitionType.fadeIn,
    );
    r.child(
      '/not_connection/',
      child: (args) => const NotConnectionPage(),
      transition: TransitionType.fadeIn,
    );
    r.module(
      '/home/',
      module: HomeModule(),
      transition: TransitionType.fadeIn,
      duration: 700.ms,
    );
  }
}
