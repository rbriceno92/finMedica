import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';

class TermsConditionsState extends Equatable {
  final String terms;
  final bool acceptedTerms;
  final bool enableContinue;
  final LoadingState loading;
  final String error;

  const TermsConditionsState({
    this.terms = '',
    this.acceptedTerms = false,
    this.enableContinue = false,
    this.loading = LoadingState.dispose,
    this.error = '',
  });

  TermsConditionsState copyWith({
    String? terms,
    bool? acceptedTerms,
    bool? enableContinue,
    LoadingState? loading,
    String? error,
  }) {
    return TermsConditionsState(
      terms: terms ?? this.terms,
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
      enableContinue: enableContinue ?? this.enableContinue,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        terms,
        acceptedTerms,
        enableContinue,
        loading,
        error,
      ];
}
