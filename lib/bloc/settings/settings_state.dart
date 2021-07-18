part of 'settings_bloc.dart';

@immutable
abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsOpened extends SettingsState {
  @override
  List<Object> get props => [];
}

class SettingsLoading extends SettingsState {
  @override
  List<Object> get props => [];
}

class SettingsLoaded extends SettingsState {
  final String appVersion;
  final double startWeight;
  final String startWeightDate;
  final double targetWeight;
  final String targetWeightDate;
  final double currentWeight;

  SettingsLoaded(
      {this.appVersion,
      this.startWeight,
      this.startWeightDate,
      this.targetWeight,
      this.targetWeightDate,
      this.currentWeight});

  @override
  List<Object> get props => [];
}
