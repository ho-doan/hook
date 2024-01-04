// Mocks generated by Mockito 5.4.2 from annotations
// in hook_ffff/test/home/provider/home_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:hook_ffff/data/models/entry.dart' as _i5;
import 'package:hook_ffff/domain/home_repository.dart' as _i3;
import 'package:hook_ffff/home/provider/home_provider.dart' as _i6;
import 'package:hook_ffff/home/provider/home_state.dart' as _i2;
import 'package:hooks_riverpod/hooks_riverpod.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:state_notifier/state_notifier.dart' as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeHomeState_0 extends _i1.SmartFake implements _i2.HomeState {
  _FakeHomeState_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [HomeRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockHomeRepository extends _i1.Mock implements _i3.HomeRepository {
  MockHomeRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i5.EntryModel>> entries() => (super.noSuchMethod(
        Invocation.method(
          #entries,
          [],
        ),
        returnValue: _i4.Future<List<_i5.EntryModel>>.value(<_i5.EntryModel>[]),
      ) as _i4.Future<List<_i5.EntryModel>>);
}

/// A class which mocks [HomeStateNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockHomeStateNotifier extends _i1.Mock implements _i6.HomeStateNotifier {
  MockHomeStateNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set onError(_i7.ErrorListener? _onError) => super.noSuchMethod(
        Invocation.setter(
          #onError,
          _onError,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get mounted => (super.noSuchMethod(
        Invocation.getter(#mounted),
        returnValue: false,
      ) as bool);
  @override
  _i4.Stream<_i2.HomeState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i4.Stream<_i2.HomeState>.empty(),
      ) as _i4.Stream<_i2.HomeState>);
  @override
  _i2.HomeState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeHomeState_0(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.HomeState);
  @override
  set state(_i2.HomeState? value) => super.noSuchMethod(
        Invocation.setter(
          #state,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i2.HomeState get debugState => (super.noSuchMethod(
        Invocation.getter(#debugState),
        returnValue: _FakeHomeState_0(
          this,
          Invocation.getter(#debugState),
        ),
      ) as _i2.HomeState);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  _i4.Future<void> fetch() => (super.noSuchMethod(
        Invocation.method(
          #fetch,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  void delete(int? index) => super.noSuchMethod(
        Invocation.method(
          #delete,
          [index],
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool updateShouldNotify(
    _i2.HomeState? old,
    _i2.HomeState? current,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateShouldNotify,
          [
            old,
            current,
          ],
        ),
        returnValue: false,
      ) as bool);
  @override
  _i7.RemoveListener addListener(
    _i8.Listener<_i2.HomeState>? listener, {
    bool? fireImmediately = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
          {#fireImmediately: fireImmediately},
        ),
        returnValue: () {},
      ) as _i7.RemoveListener);
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
}