part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeStarted extends HomeEvent {
  @override
  List<Object> get props => [];
}

class HomeButtonPressed extends HomeEvent {
  const HomeButtonPressed(this.word);

  final String word;

  @override
  List<String> get props => [word];
}
