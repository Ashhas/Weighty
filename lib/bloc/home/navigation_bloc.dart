import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';

part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(DashboardOpenedState());

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is HomeStarted) {
      yield* _mapHomeStartedToState();
    } else if (event is NavigateToDashboard) {
      yield* _mapNavigateToDashboardToState(event, state);
    }
  }

  Stream<NavigationState> _mapHomeStartedToState() async* {}

  Stream<NavigationState> _mapNavigateToDashboardToState(
      NavigationEvent event, NavigationState state) async* {
    yield DashboardOpenedState();
  }
}
