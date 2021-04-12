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
  final bool themeDarkMode;

  ThemeChangedEvent(this.themeDarkMode) : assert(themeDarkMode != null);

  @override
  List<Object> get props => [themeDarkMode];
}
