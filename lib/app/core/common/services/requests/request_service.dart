import 'package:anime_app_tv/app/core/common/services/requests/request_result.dart';

abstract class RequestService {
  Future<RequestResult> get(String url, {Map<String, dynamic>? headers});
  Future<RequestResult> post(String url, {Map<String, dynamic> body, Map<String, dynamic>? headers});
  Future<RequestResult> put(String url, {Map<String, dynamic> body, Map<String, dynamic>? headers});
  Future<RequestResult> patch(String url, {Map<String, dynamic> body, Map<String, dynamic>? headers});
  Future<RequestResult> delete(String url, {Map<String, dynamic> body, Map<String, dynamic>? headers});
}
