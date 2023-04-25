import 'package:app/features/frequent_questions/data/models/frequent_questions_response.dart';
import 'package:app/features/frequent_questions/domain/entities/frequent_questions.dart';
import 'package:app/features/frequent_questions/domain/repositories/frequent_questions_repositories.dart';
import 'package:app/features/frequent_questions/domain/use_case/get_frequent_questions.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_frequent_questions_test.mocks.dart';

@GenerateMocks([FrequentQuestionsRepository])
void main() {
  late FrequentQuestionsUseCase casoDeUso;
  late MockFrequentQuestionsRepository repositorio;

  setUp(() {
    repositorio = MockFrequentQuestionsRepository();
    casoDeUso = FrequentQuestionsUseCase(repository: repositorio);
  });

  test(
    'Deberia obtener la lista de procedimientos proximos',
    () async {
      const value = FrequentQuestionsResponse(result: [
        FrequentQuestions(
            answer:
                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem.',
            question: '¿Qué es FinMédica?')
      ]);
      when(repositorio.frequentQuestions())
          .thenAnswer((_) async => const Right(value));
      // act
      final result = await casoDeUso(ParametroVacio());
      //assert
      expect(result, const Right(value));
      // Verifica que el repositorio fue llamado
      verify(repositorio.frequentQuestions());
      // Verifica que ya el repositorio no tenga mas interacciones
      verifyNoMoreInteractions(repositorio);
    },
  );
}
