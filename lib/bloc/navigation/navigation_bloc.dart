import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';

part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationDefault());

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is NavigateToScreen) {
      yield* _mapNavigateToScreenToState(event.screenIndex);
    }
  }

  Stream<NavigationState> _mapNavigateToScreenToState(int screenIndex) async* {
    print('Navigating to screen: $screenIndex');
    yield NavigatedToScreen();
  }
}
