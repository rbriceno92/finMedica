import 'package:app/features/signup/domain/entities/sign_up_data.dart';
import 'package:equatable/equatable.dart';

abstract class TermsConditionsEvent extends Equatable {
  const TermsConditionsEvent();
}

class DonwloadTerms extends TermsConditionsEvent {
  @override
  List<Object?> get props => [];
}

class AcceptedTermsChange extends TermsConditionsEvent {
  final bool acceptedTerms;

  const AcceptedTermsChange({required this.acceptedTerms});
  @override
  List<Object?> get props => [acceptedTerms];
}

class DisposeLoading extends TermsConditionsEvent {
  @override
  List<Object?> get props => [];
}

class SendSignUpData extends TermsConditionsEvent {
  final void Function(String? userId) next;
  final void Function(String message) error;
  final SignUpData data;

  const SendSignUpData(
      {required this.next, required this.data, required this.error});

  @override
  List<Object?> get props => [next];
}
