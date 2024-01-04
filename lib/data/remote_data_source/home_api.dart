import 'dart:developer';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:hook_ffff/data/models/entries.dart';
import 'package:hook_ffff/data/models/entry.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'api_client.dart';

final homeApiProvider = Provider<HomeApi>(HomeApiImpl.new);

abstract class HomeApi {
  Future<List<EntryModel>> entries();
}

class HomeApiImpl extends HomeApi {
  final Ref _ref;

  HomeApiImpl(this._ref);

  Dio get _dio => _ref.read(dioProvider);
  PersistCookieJar get cookieJar => _ref.read(apiCookieProvider);
  @override
  Future<List<EntryModel>> entries() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/entries');
      await cookieJar.saveFromResponse(
        Uri.parse('https://api.publicapis.org/'),
        [Cookie('sessionId', 'sessionId')],
      );
      final data = response.data ?? <String, dynamic>{};
      return EntriesModel.fromJson(data).entries;
    } on DioException catch (e) {
      log(e.requestOptions.path);
      log(e.message ?? e.error?.toString() ?? 'none');
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
