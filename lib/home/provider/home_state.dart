import 'package:equatable/equatable.dart';
import 'package:hook_ffff/data/models/entry.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInit extends HomeState {
  const HomeInit();
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading();
  @override
  List<Object?> get props => [];
}

class HomeFailure extends HomeState {
  final String error;

  const HomeFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class HomeSuccess extends HomeState {
  final List<EntryModel> entries;

  const HomeSuccess(this.entries);

  @override
  List<Object?> get props => [entries];
}

extension HomeStateX on HomeState {
  HomeSuccess? get success {
    if (this is HomeSuccess) {
      return this as HomeSuccess;
    }
    return null;
  }
}
