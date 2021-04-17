part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingsStarted extends SettingsEvent {
  @override
  List<Object> get props => [];
}
