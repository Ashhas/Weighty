part of 'export_bloc.dart';

@immutable
abstract class ExportEvent extends Equatable {
  const ExportEvent();

  @override
  List<Object> get props => [];
}

class StartExport extends ExportEvent {
  @override
  List<Object> get props => [];
}
