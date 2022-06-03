part of 'badge_bloc.dart';

@immutable
abstract class BadgeState extends Equatable {}

class BadgeInitial extends BadgeState {
  @override
  List<Object?> get props => [];
}

class BadgeLoading extends BadgeState {
  @override
  List<Object?> get props => [];
}

class BadgeLoadedState extends BadgeState {
  BadgeLoadedState(this.characters);

  final List<CharacterComicsModel> characters;

  @override
  List<Object?> get props => [characters];
}

class BadgeErrorState extends BadgeState {
  BadgeErrorState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}
