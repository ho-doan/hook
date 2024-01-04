import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hook_ffff/data/models/entry.dart';
import 'package:hook_ffff/domain/home_repository.dart';
import 'package:hook_ffff/home/provider/home_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:collection/collection.dart';

// @visibleForTesting
// late StreamController<HomeState?> controllerEntriesAutoDispose;
@visibleForTesting
final controllerEntriesAutoDispose = StreamController<HomeState?>();

final homeStateNotifierProvider =
    StateNotifierProvider<HomeStateNotifier, HomeState>(HomeStateNotifier.new);

final entriesProviderOld = Provider<HomeState>((ref) {
  return ref.watch(homeStateNotifierProvider.select((value) => value));
});
final entriesProvider = homeStateNotifierProvider.select((value) => value);

final entriesProviderAutoDispose = Provider.autoDispose<HomeState>((ref) {
  // controllerEntriesAutoDispose = StreamController<HomeState?>();
  ref.onDispose(() {
    controllerEntriesAutoDispose.sink.add(null);
    // controllerEntriesAutoDispose.close();
  });
  final state = ref.watch(homeStateNotifierProvider);
  controllerEntriesAutoDispose.sink.add(state);
  return state;
});

final entryProviderAutoDispose =
    Provider.family.autoDispose<EntryModel?, String?>((ref, aPI) {
  // controllerEntriesAutoDispose = StreamController<HomeState?>();
  ref.onDispose(() {
    // controllerEntriesAutoDispose.close();
  });
  return ref
      .watch(homeStateNotifierProvider)
      .success
      ?.entries
      .firstWhereOrNull((e) => e.aPI == aPI);
});

class HomeStateNotifier extends StateNotifier<HomeState> {
  HomeStateNotifier(this._ref) : super(const HomeInit());
  final Ref _ref;

  HomeRepository get _repository => _ref.watch(homeRepositoryProvider);
  Future<void> fetch() async {
    await Future.delayed(Duration.zero);
    try {
      state = const HomeLoading();
      final entries = await _repository.entries();
      state = HomeSuccess(List.from(entries));
    } catch (e) {
      state = HomeFailure(e.toString());
    }
  }

  void delete(int index) {
    if (state is HomeSuccess) {
      final s = state as HomeSuccess;
      state = HomeSuccess(List.from(s.entries)..removeAt(index));
    }
  }
}
