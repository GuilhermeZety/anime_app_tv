// import 'package:anime_app_tv/app/core/common/services/connection/connection_service.dart';
// import 'package:dart_ping/dart_ping.dart';

// class PingConnectionServiceImpl extends ConnectionService {
//   @override
//   Future<bool> get isConnected async {
//     try {
//       Ping ping = Ping('8.8.8.8', count: 1, forceCodepage: true);
//       var response = await ping.stream.first;
//       return response.error == null;
//     } catch (e) {
//       return false;
//     }
//   }
// }
