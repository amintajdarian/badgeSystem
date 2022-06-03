part of 'badge_bloc.dart';

abstract class BadgeEvent extends Equatable {}

class BadgeLoadedEvent extends BadgeEvent {
  @override
  List<Object?> get props => [];
}

class BadgeErrorEvent extends BadgeEvent {
  @override
  List<Object?> get props => [];
}

class BageEditedEvent extends BadgeEvent {
  final CharacterComicsModel character;
  final int index;
  BageEditedEvent({required this.character, required this.index});
  @override
  List<Object?> get props => [index, character];
}
