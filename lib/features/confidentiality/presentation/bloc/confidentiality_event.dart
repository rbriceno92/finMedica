import 'package:equatable/equatable.dart';

abstract class ConfidentialityEvent extends Equatable {
  const ConfidentialityEvent();
}

class ConfidentialityPrivate extends ConfidentialityEvent {
  @override
  List<Object?> get props => [];
}
