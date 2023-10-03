// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:anime_app_tv/main.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageCacheService {
  //SingleTon
  ImageCacheService._();
  static final ImageCacheService _instance = ImageCacheService._();
  factory ImageCacheService() => ImageCacheService._instance;
  //

  // final Timer _timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
  //   log('verify queue');
  //   await queue.onComplete;
  //   log('verified queue');
  // });

  Future<Uint8List?> getImage(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var cached = prefs.getString(url);
      final List<int>? data = (cached != null ? List<int>.from(jsonDecode(cached)) : null);

      if (data != null && data.isNotEmpty) {
        return Uint8List.fromList(data);
      }
      final response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));

      if (response.statusCode! > 199 && response.statusCode! < 300) {
        await prefs.setString(url, jsonEncode(response.data));
        return Uint8List.fromList(response.data);
      }
    } catch (e) {
      log(e.toString(), name: 'ImageCacheService', error: e);
    }
    return null;
  }

  Future<ImageCachedResponse> getR(String url) async {
    var cached = session.prefs.getString(url);
    final List<int>? data = (cached != null ? List<int>.from(jsonDecode(cached)) : null);

    if (data != null && data.isNotEmpty) {
      log('aqui');
      return ImageCachedResponse(
        type: ImageResponseType.bytes,
        bytes: Uint8List.fromList(
          data,
        ),
      );
    }
    log('saiu');
    // queue.add(() => download(url));
    return ImageCachedResponse(type: ImageResponseType.network, url: url);
  }

  Future download(String url) async {
    log('download');
    try {
      await Dio()
          .get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      )
          .then((value) {
        if (value.statusCode! > 199 && value.statusCode! < 300) {
          session.prefs.setString(url, jsonEncode(value.data));
        }
      });
    } catch (e) {
      //
    }
  }
}

class ImageCachedResponse {
  final ImageResponseType type;
  final Uint8List? bytes;
  final String? url;

  ImageCachedResponse({
    required this.type,
    this.bytes,
    this.url,
  });
}

enum ImageResponseType {
  bytes,
  network,
}
