
part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeLoadStarted extends ThemeEvent {
  @override
  List<Object> get props => [];
}

class ThemeChanged extends ThemeEvent {
  final bool themeDarkMode;

  ThemeChanged(this.themeDarkMode) : assert(themeDarkMode != null);

  @override
  List<Object> get props => [themeDarkMode];
}