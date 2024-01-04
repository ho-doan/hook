import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hook_ffff/home/detail/detail_page.dart';
import 'package:hook_ffff/home/provider/home_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'provider/home_state.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(homeStateNotifierProvider.notifier);

    useEffect(() {
      Future.microtask(notifier.fetch);
      return null;
    }, []);
    final state = ref.watch(entriesProviderAutoDispose);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: _buildBody(state, ref),
    );
  }

  Widget _buildBody(HomeState state, WidgetRef ref) {
    switch (state) {
      case HomeInit():
      case HomeLoading():
        return const Center(
          child: CircularProgressIndicator(),
        );
      case HomeFailure():
        return Center(
          child: Text(
            state.error,
            textAlign: TextAlign.center,
          ),
        );
      case HomeSuccess():
        return Column(
          children: [
            Builder(builder: (context) {
              return TextButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (ctx) => const HomeBottomSheet(),
                ),
                child: const Text('dialog'),
              );
            }),
            Expanded(
              child: ListView(
                children: [
                  for (final entry in state.entries)
                    Builder(builder: (context) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => DetailPage(aPI: entry.aPI),
                          ),
                        ),
                        // ref.watch(homeStateNotifierProvider.notifier).delete(
                        //       state.entries.indexOf(entry),
                        //     ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            entry.aPI ?? entry.description ?? 'None',
                          ),
                        ),
                      );
                    }),
                ],
              ),
            ),
          ],
        );
      default:
        return Container();
    }
  }
}

class HomeBottomSheet extends HookConsumerWidget {
  const HomeBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(entriesProvider);
    return Material(
      child: ListView(
        children: [
          if (state is HomeSuccess)
            for (final entry in state.entries)
              GestureDetector(
                onTap: () =>
                    ref.watch(homeStateNotifierProvider.notifier).delete(
                          state.entries.indexOf(entry),
                        ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    entry.aPI ?? entry.description ?? 'None',
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
