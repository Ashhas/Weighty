part of 'navigation_bloc.dart';

@immutable
abstract class NavigationState extends Equatable {
  const NavigationState();
}

class NavigationDefaultState extends NavigationState {
  @override
  List<Object> get props => [];
}

class DashboardOpenedState extends NavigationState {
  @override
  List<Object> get props => [];
}
