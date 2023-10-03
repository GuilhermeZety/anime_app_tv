import 'package:anime_app_tv/app/core/common/services/connection/connection_service.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectionCheckerPlusServiceImpl extends ConnectionService {
  @override
  Future<bool> get isConnected async {
    try {
      return await InternetConnection().hasInternetAccess;
    } catch (e) {
      return false;
    }
  }
}
