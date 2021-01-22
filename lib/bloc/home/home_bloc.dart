import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeStarted) {
      yield* _mapHomeStartedToState();
    } else if (event is HomeButtonPressed) {
      yield* _mapHomeButtonPressedToState(event, state);
    }
  }

  Stream<HomeState> _mapHomeStartedToState() async* {}

  Stream<HomeState> _mapHomeButtonPressedToState(
      HomeEvent event, HomeState state) async* {
    yield HomeLoading();
    try {
      yield HomeLoaded(event.props.toString());
    } catch (_) {
      yield HomeError();
    }
  }
}
