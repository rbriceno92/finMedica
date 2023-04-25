import 'package:equatable/equatable.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();
}

class FetchData extends StoreEvent {
  final void Function(String message) onError;
  const FetchData(this.onError);

  @override
  List<Object?> get props => [];
}

class DisposeLoading extends StoreEvent {
  @override
  List<Object?> get props => [];
}
