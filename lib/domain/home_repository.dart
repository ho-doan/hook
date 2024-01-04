import 'package:hook_ffff/data/models/entry.dart';
import 'package:hook_ffff/data/remote_data_source/home_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homeRepositoryProvider = Provider<HomeRepository>(HomeRepositoryImlp.new);

abstract class HomeRepository {
  Future<List<EntryModel>> entries();
}

class HomeRepositoryImlp extends HomeRepository {
  final Ref _ref;

  HomeRepositoryImlp(this._ref);
  HomeApi get _api => _ref.read(homeApiProvider);

  @override
  Future<List<EntryModel>> entries() => _api.entries();
}
