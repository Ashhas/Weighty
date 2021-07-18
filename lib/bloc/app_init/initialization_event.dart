part of 'initialization_bloc.dart';

@immutable
abstract class InitializationEvent extends Equatable {
  const InitializationEvent();
}

class InitializeApp extends InitializationEvent {
  @override
  List<Object> get props => [];
}

class FinishOnBoarding extends InitializationEvent {
  @override
  List<Object> get props => [];
}