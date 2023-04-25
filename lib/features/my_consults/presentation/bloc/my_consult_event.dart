import 'package:app/features/my_consults/domain/entities/chips.dart';
import 'package:equatable/equatable.dart';

abstract class MyConsultEvent extends Equatable {
  const MyConsultEvent();
}

class LoadMyConsults extends MyConsultEvent {
  final Map states;

  const LoadMyConsults({required this.states});

  @override
  List<Object?> get props => [states];
}

class AddOrRemoveFilter extends MyConsultEvent {
  final ChipFilter filter;

  const AddOrRemoveFilter({required this.filter});

  @override
  List<Object?> get props => [filter];
}

class SetPrivacyState extends MyConsultEvent {
  final bool privacy;
  final int position;

  const SetPrivacyState({required this.privacy, required this.position});

  @override
  List<Object?> get props => [privacy, position];
}

class CleanMessage extends MyConsultEvent {
  @override
  List<Object?> get props => [];
}
