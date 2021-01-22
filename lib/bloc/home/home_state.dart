part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  const HomeLoaded(this.homeText);

  final String homeText;

  @override
  List<String> get props => [homeText];
}

class HomeError extends HomeState {
  @override
  List<Object> get props => [];
}
