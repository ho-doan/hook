import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hook_ffff/home/detail/detail_page.dart';
import 'package:hook_ffff/domain/home_repository.dart';
import 'package:hook_ffff/home/provider/home_provider.dart';
import 'package:hook_ffff/home/provider/home_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mock_data/entries.dart';
import 'home_provider_test.mocks.dart';

class MockListener<T> extends Mock {
  void call(T? previous, T? value);
}

@GenerateMocks([
  HomeRepository,
  HomeStateNotifier,
])
void main() {
  late MockHomeRepository homeRepository;
  final listener = MockListener<HomeState>();
  final listenerEntries = MockListener<HomeState>();
  final listenerAuEntries = MockListener<HomeState>();
  int isCalled = 0;

  late ProviderContainer container;

  HomeStateNotifier homeProvider() {
    container = ProviderContainer(
      overrides: [
        homeRepositoryProvider.overrideWithValue(homeRepository),
      ],
    )
      ..listen(
        entriesProvider,
        listenerEntries,
        fireImmediately: true,
      )
      ..listen(
        entriesProviderAutoDispose,
        listenerAuEntries,
        fireImmediately: true,
      )
      ..listen(
        homeStateNotifierProvider,
        listener,
        fireImmediately: true,
      );
    addTearDown(() {
      container.dispose();
      homeRepository = MockHomeRepository();
    });
    return container.read(homeStateNotifierProvider.notifier);
  }

  MaterialApp widget(ProviderContainer container, String? aPI) {
    return MaterialApp(
      home: UncontrolledProviderScope(
        container: container,
        child: DetailPage(
          aPI: aPI,
        ),
      ),
    );
  }

  setUpAll(() {
    homeRepository = MockHomeRepository();
    isCalled = 0;
    // controllerEntriesAutoDispose.stream.listen(print);
    // controllerEntry.stream.listen(print);
  });

  group('fetch', () {
    test(
      'homeProvider#failure',
      () async {
        final notifier = homeProvider();
        final e = Exception();
        when(homeRepository.entries()).thenAnswer(
          (v) async => throw e,
        );
        await notifier.fetch();
        verifyInOrder([
          listener(any, const HomeInit()),
          listener(any, const HomeLoading()),
          listener(any, HomeFailure(e.toString())),
        ]);
      },
    );
    test(
      'homeProvider#success',
      () async {
        final notifier = homeProvider();
        when(homeRepository.entries()).thenAnswer(
          (v) async => mockEntries,
        );
        await notifier.fetch();
        verifyInOrder([
          listener(any, const HomeInit()),
          listener(any, const HomeLoading()),
          listener(any, HomeSuccess(mockEntries)),
        ]);
      },
    );
    test('homeProvider#delete entry', () async {
      final notifier = homeProvider();
      when(homeRepository.entries()).thenAnswer(
        (v) async => mockEntries,
      );
      await notifier.fetch();
      notifier.delete(0);
      verifyInOrder([
        listener(any, const HomeInit()),
        listener(any, const HomeLoading()),
        listener(any, HomeSuccess(mockEntries)),
        listener(any, HomeSuccess(List.from(mockEntries)..removeAt(0)))
      ]);
    });
    test('entriesProvider#failure', () async {
      final notifier = homeProvider();
      final e = Exception();
      when(homeRepository.entries()).thenAnswer(
        (v) async => throw e,
      );
      await notifier.fetch();
      verifyInOrder([
        listener(any, const HomeInit()),
        listener(any, const HomeLoading()),
        listener(any, HomeFailure(e.toString())),
      ]);
      verifyInOrder([
        listenerEntries(any, const HomeInit()),
        listenerEntries(any, const HomeLoading()),
        listenerEntries(any, HomeFailure(e.toString())),
      ]);
    });
    test('entriesProvider#success', () async {
      final notifier = homeProvider();
      when(homeRepository.entries()).thenAnswer(
        (v) async => mockEntries,
      );
      await notifier.fetch();
      verifyInOrder([
        listener(any, const HomeInit()),
        listener(any, const HomeLoading()),
        listener(any, HomeSuccess(mockEntries)),
      ]);
      verifyInOrder([
        listenerEntries(any, const HomeInit()),
        listenerEntries(any, const HomeLoading()),
        listenerEntries(any, HomeSuccess(mockEntries)),
      ]);
    });
    test('entriesProvider#delete entry', () async {
      final notifier = homeProvider();
      when(homeRepository.entries()).thenAnswer(
        (v) async => mockEntries,
      );
      await notifier.fetch();
      notifier.delete(0);
      verifyInOrder([
        listener(any, const HomeInit()),
        listener(any, const HomeLoading()),
        listener(any, HomeSuccess(mockEntries)),
        listener(any, HomeSuccess(List.from(mockEntries)..removeAt(0)))
      ]);
      verifyInOrder([
        listenerEntries(any, const HomeInit()),
        listenerEntries(any, const HomeLoading()),
        listenerEntries(any, HomeSuccess(mockEntries)),
        listenerEntries(any, HomeSuccess(List.from(mockEntries)..removeAt(0)))
      ]);
    });
    test('entriesProviderAutoDispose#failure', () async* {
      final notifier = homeProvider();
      final e = Exception();
      when(homeRepository.entries()).thenAnswer(
        (v) async => throw e,
      );
      await notifier.fetch();
      verifyInOrder([
        listener(any, const HomeInit()),
        null,
        listener(any, const HomeLoading()),
        null,
        listener(any, HomeFailure(e.toString())),
        null,
      ]);

      expect(
        controllerEntriesAutoDispose.stream,
        emitsInOrder([
          const HomeInit(),
          const HomeLoading(),
          HomeFailure(e.toString()),
        ]),
      );
    }, timeout: const Timeout(Duration(seconds: 5)));
    test('entriesProviderAutoDispose#success', () async* {
      final notifier = homeProvider();
      when(homeRepository.entries()).thenAnswer(
        (v) async => mockEntries,
      );
      await notifier.fetch();
      verifyInOrder([
        listener(any, const HomeInit()),
        listener(any, const HomeLoading()),
        listener(any, HomeSuccess(mockEntries)),
      ]);
      verifyInOrder([
        listenerAuEntries(any, const HomeInit()),
        listenerAuEntries(any, const HomeLoading()),
        listenerAuEntries(any, HomeSuccess(mockEntries)),
      ]);
      expect(
        controllerEntriesAutoDispose.stream,
        emitsInOrder([
          const HomeInit(),
          null,
          const HomeLoading(),
          null,
          HomeSuccess(mockEntries),
          null,
        ]),
      );
    });
    test('entriesProviderAutoDispose#delete entry', () async* {
      final notifier = homeProvider();
      when(homeRepository.entries()).thenAnswer(
        (v) async => mockEntries,
      );
      await notifier.fetch();
      notifier.delete(0);
      verifyInOrder([
        listener(any, const HomeInit()),
        listener(any, const HomeLoading()),
        listener(any, HomeSuccess(mockEntries)),
        listener(any, HomeSuccess(List.from(mockEntries)..removeAt(0)))
      ]);
      expect(
        controllerEntriesAutoDispose.stream,
        emitsInOrder([
          const HomeInit(),
          null,
          const HomeLoading(),
          null,
          HomeSuccess(mockEntries),
          null,
          HomeSuccess(List.from(mockEntries)..removeAt(0)),
          null,
        ]),
      );
    });
    test('controllerEntry#success', () async {
      final notifier = homeProvider();
      when(homeRepository.entries()).thenAnswer(
        (v) async => mockEntries,
      );
      await notifier.fetch();
      verifyInOrder([
        listener(any, const HomeInit()),
        listener(any, const HomeLoading()),
        listener(any, HomeSuccess(mockEntries))
      ]);

      final data =
          container.read(entryProviderAutoDispose(mockEntries.last.aPI));

      expect(data?.aPI, mockEntries.last.aPI);
    });
    testWidgets('controllerEntry#not found', (tester) async {
      when(homeRepository.entries()).thenAnswer(
        (v) async {
          isCalled += 1;
          if ((isCalled) == 2) {
            return List.from(mockEntries);
          }
          return List.from(mockEntries)..removeLast();
        },
      );

      final notifier = homeProvider();
      verifyNever(homeRepository.entries());

      await tester.runAsync(() => notifier.fetch());

      await tester.pumpWidget(widget(container, mockEntries.last.aPI));
      await tester.pumpAndSettle();

      expect(find.text(mockEntries.last.aPI!), findsOneWidget);
      verify(homeRepository.entries()).called(2);
    });
  });
}
