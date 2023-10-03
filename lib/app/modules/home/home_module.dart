import 'package:anime_app_tv/app/modules/home/presentation/cubit/home_cubit.dart';
import 'package:anime_app_tv/app/modules/home/presentation/pages/home_page.dart';
import 'package:anime_app_tv/app/modules/home/presentation/pages/initial/cubit/initial_cubit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<HomeCubit>(() => HomeCubit());
    i.addLazySingleton<InitialCubit>(() => InitialCubit());
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (args) => const HomePage(),
      transition: TransitionType.fadeIn,
      duration: 700.ms,
    );
  }
}
