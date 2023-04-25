import 'package:equatable/equatable.dart';

class FrequentQuestionsState extends Equatable {
  final bool loading;
  final List? frequentQuestions;
  final String errorMessage;

  const FrequentQuestionsState(
      {this.loading = false, this.frequentQuestions, this.errorMessage = ''});

  FrequentQuestionsState copyWith(
      {bool? loading, List? frequentQuestions, String? errorMessage}) {
    return FrequentQuestionsState(
        loading: loading ?? this.loading,
        frequentQuestions: frequentQuestions ?? this.frequentQuestions,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [loading, frequentQuestions, errorMessage];
}
