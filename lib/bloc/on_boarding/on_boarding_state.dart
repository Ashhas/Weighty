part of 'on_boarding_bloc.dart';

@immutable
abstract class OnBoardingState extends Equatable {}

class OnBoardingOpenedState extends OnBoardingState {
  @override
  List<Object> get props => [];
}

class OnBoardingFinished extends OnBoardingState {
  @override
  List<Object> get props => [];
}

class OnBoardingErrorState extends OnBoardingState {
  final Exception exception;

  OnBoardingErrorState({@required this.exception});

  @override
  List<Object> get props => [exception];
}
