part of 'theme_bloc.dart';

@immutable
abstract class ThemeState extends Equatable {
  const ThemeState();
}

class CurrentThemeState extends ThemeState {
  final ThemeMode themeMode;

  CurrentThemeState(this.themeMode) : assert(themeMode != null);

  @override
  List<Object> get props => [themeMode];
}
