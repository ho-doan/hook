import 'dart:developer';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioProvider = Provider((ref) {
  final cookieJar = ref.watch(apiCookieProvider);

  /// define for local server, when reconfigure when authentication complete.
  final headers = <String, dynamic>{'Authorization': 'Bearer X'};

  cookieJar
      .loadForRequest(Uri.parse('https://api.publicapis.org/'))
      .then(print);

  final dio = Dio()
    ..options.baseUrl = 'https://api.publicapis.org/'
    ..options.headers = headers
    ..interceptors.add(
      CookieManager(cookieJar),
    );
  assert(
    () {
      dio.interceptors.add(LogInterceptor());
      dio.interceptors.clear();
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            log('#onRequest');
            return handler.next(options); //continue
          },
          onResponse: (response, handler) {
            log('#onResponse');
            return handler.next(response); // continue
          },
          onError: (e, handler) {
            log('#onError ${e.response.toString()}');
            return handler.next(e); //continue
          },
        ),
      );
      return true;
    }(),
  );

  ref.onDispose(dio.close);
  return dio;
});

final cookieStoredDirectoryProvider = Provider<String>((ref) {
  throw Exception('Provider was not initialized');
});

final apiCookieProvider = Provider((ref) {
  final directory = ref.watch(cookieStoredDirectoryProvider);
  final cookieJar = PersistCookieJar(
    ignoreExpires: true,
    storage: FileStorage(directory),
  );
  return cookieJar;
});
