part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState extends Equatable {
  const NavigationState();
}

class NavigationDefault extends NavigationState {
  @override
  List<Object> get props => [];
}

class NavigatedToScreen extends NavigationState {
  @override
  List<Object> get props => [];
}
