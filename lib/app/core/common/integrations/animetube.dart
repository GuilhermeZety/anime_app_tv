import 'package:anime_app_tv/app/core/common/enums/video_quality_enum.dart';
import 'package:anime_app_tv/app/core/common/integrations/integration.dart';

class Anitube implements Integration {
  @override
  final String baseUrl = 'https://www.anitube.vip/';

  @override
  String search(String value) => '${baseUrl}busca.php?s=$value&submit=Buscar';

  @override
  String episodeData(String uuid) => '${baseUrl}video/$uuid';
  @override
  String animeData(String uuid, bool dublado, int page) => '$baseUrl${dublado ? 'animes-dublado' : 'anime'}/$uuid/page/$page';
  @override
  String watch(String uuid, VideoQualityEnum quality, bool contains2) =>
      '${baseUrl}playerricas.php?name=apphd/.mp4&img=https://www.anitube.vip/media/videos/tmb/$uuid/default.jpg&url=https://ikaros.anicdn.net/${getResolution(quality, contains2)}/$uuid.mp4';

  @override
  String get releases => baseUrl;

  @override
  String get calendar => '${baseUrl}calendario';

  String getResolution(VideoQualityEnum quality, bool contains2) {
    switch (quality) {
      case VideoQualityEnum.fullhd:
        return 'appfullhd';
      case VideoQualityEnum.hd:
        if (contains2) {
          return 'apphd2';
        }
        return 'apphd';
      case VideoQualityEnum.sd:
        if (contains2) {
          return 'appsd2';
        }
        return 'appsd';
    }
  }
}
