part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class NavigateToScreen extends NavigationEvent {
  final int screenIndex;

  NavigateToScreen(this.screenIndex);

  @override
  List<int> get props => [screenIndex];
}
