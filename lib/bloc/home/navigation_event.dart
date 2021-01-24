part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class HomeStarted extends NavigationEvent {
  @override
  List<Object> get props => [];
}

class NavigateToDashboard extends NavigationEvent {
  @override
  List<String> get props => [];
}
