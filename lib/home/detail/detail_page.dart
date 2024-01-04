import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hook_ffff/data/models/entry.dart';
import 'package:hook_ffff/home/provider/home_provider.dart';
import 'package:hook_ffff/home/provider/home_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailPage extends HookConsumerWidget {
  const DetailPage({super.key, this.aPI});

  final String? aPI;

  Widget buildBody(EntryModel? state, HomeState homeState) {
    switch (homeState) {
      case HomeLoading():
        return const Center(
          child: CircularProgressIndicator(),
        );
      case HomeFailure():
        return Center(
          child: Text('error ${homeState.error}'),
        );
      case HomeSuccess():
        return Center(
          child: Text(state?.aPI ?? 'NONE'),
        );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aaa = useRef<String?>('nullfdsdfsd');
    final notifier = ref.read(homeStateNotifierProvider.notifier);
    final homeState = ref.watch(homeStateNotifierProvider);
    final state = ref.watch(entryProviderAutoDispose(aaa.value ?? aPI));
    final reload = useRef(true);

    useEffect(() {
      if (homeState is HomeLoading) {
        reload.value = false;
        return null;
      }
      if (state == null && homeState is HomeSuccess && !reload.value) {
        log('not found');
        return null;
      }
      if (state == null && homeState is HomeSuccess && reload.value) {
        // aaa.value = null;
        Future.microtask(notifier.fetch);
        return null;
      }
      return null;
    }, [state, homeState]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: buildBody(state, homeState),
    );
  }
}

class TimerWidget extends ConsumerWidget {
  const TimerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
