import 'package:equatable/equatable.dart';

class FrequentQuestions extends Equatable {
  final String question;
  final String answer;

  const FrequentQuestions({
    required this.question,
    required this.answer,
  });

  FrequentQuestions copyWith({
    String? question,
    String? answer,
  }) {
    return FrequentQuestions(
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }

  @override
  List<Object?> get props => [question, answer];
}
