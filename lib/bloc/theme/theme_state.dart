part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ThemeHasChanged extends ThemeState {
  ThemeHasChanged();

  @override
  List<Object> get props => [];
}

class CurrentThemeState extends ThemeState {
  final ThemeMode themeMode;
  final bool isDarkTheme;

  CurrentThemeState({@required this.themeMode, this.isDarkTheme});

  @override
  List<Object> get props => [];
}
