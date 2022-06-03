import 'package:badge_system/dashboard/service/badge_database.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/character_comics_model.dart';

part 'badge_event.dart';
part 'badge_state.dart';

class BadgeBloc extends Bloc<BadgeEvent, BadgeState> {
  BadgeBloc({required this.box}) : super(BadgeInitial()) {
    on<BadgeLoadedEvent>((event, emit) async {
      emit(BadgeLoading());
      try {
        emit(BadgeLoadedState(await box.getCharacters()));
      } catch (e) {
        emit(BadgeErrorState(e.toString()));
        emit(BadgeInitial());
      }
    });
    on<BageEditedEvent>((event, emit) async {
      try {
        box.updateCharacter(event.index, event.character);
        emit(BadgeLoadedState(await box.getCharacters()));
      } catch (e) {
        emit(BadgeErrorState(e.toString()));
        emit(BadgeInitial());
      }
    });
  }

  final BadgeDatabase box;
}
