import 'package:app/features/dashboard/domain/repositories/dashboard_repositories.dart';
import 'package:app/features/dashboard/domain/use_cases/get_next_consults.dart';
import 'package:app/features/my_consults/data/models/consult_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_next_consults_test.mocks.dart';

@GenerateMocks([DashboardRepository])
void main() {
  late GetNextConsults nextConsults;
  late MockDashboardRepository mockDashboardRepository;

  setUp(() {
    mockDashboardRepository = MockDashboardRepository();
    nextConsults = GetNextConsults(repository: mockDashboardRepository);
  });

  final nextTwoConsults = <ConsultModel>[];

  var statesParam = {};

  test('Should get a list of consults', () async {
    when(mockDashboardRepository.getNextConsults(statesParam))
        .thenAnswer((_) async => Right(nextTwoConsults));

    final result = await nextConsults(statesParam);

    expect(result, Right(nextTwoConsults));

    verify(mockDashboardRepository.getNextConsults(statesParam));
    verifyNoMoreInteractions(mockDashboardRepository);
  });
}
