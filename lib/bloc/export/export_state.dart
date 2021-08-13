part of 'export_bloc.dart';

@immutable
abstract class ExportState extends Equatable {
  const ExportState();

  @override
  List<Object> get props => [];
}

class ExportInitialState extends ExportState {
  @override
  List<Object> get props => [];
}

class ExportStart extends ExportState {
  @override
  List<Object> get props => [];
}

class ExportFinished extends ExportState {
  @override
  List<Object> get props => [];
}
