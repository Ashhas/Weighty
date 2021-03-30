part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeLoadStartedEvent extends ThemeEvent {
  @override
  List<Object> get props => [];
}

class ThemeChangedEvent extends ThemeEvent {
  final String themeModeString;

  ThemeChangedEvent(this.themeModeString) : assert(themeModeString != null);

  @override
  List<Object> get props => [themeModeString];
}
