
import 'package:app/features/directory/domain/entities/directory.dart';
import 'package:app/features/directory/domain/entities/doctor.dart';
import 'package:app/features/directory/domain/repositories/directory_repository.dart';
import 'package:app/features/directory/domain/use_cases/get_directory_by_specialist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_directory_test.mocks.dart';

@GenerateMocks([DirectoryRepository])
void main(){
  late GetDirectory getDirectory;
  late MockDirectoryRepository dashboardRepository;

  setUp(() {
    dashboardRepository = MockDirectoryRepository();
    getDirectory = GetDirectory(repository: dashboardRepository);
  });

  const directory = Directory(
      speciality: [
        'Cardiología',
        'Pediatría',
        'Cirugía',
        'Dermatología',
        'Gastroenterología',
        'Ginegología',
      ],
      doctors: [
        Doctor(
            name: 'Fernanda Rodriguez del vizo',
            speciality: 'Cardiología',
            consultory: 'Piso 5 - consultorio 3',
            phone_number: '(000) - 000 00 01'
          ),
        Doctor(
            name: 'Indira gafaro',
            speciality: 'Cardiología',
            consultory: 'Piso 3 - consultorio 1',
            phone_number:'(000) - 344 03 01'
        ),
        Doctor(
            name: 'Boris Ramirez',
            speciality: 'Pediatría',
            consultory: 'Piso 4 - consultorio 2',
            phone_number: '(564) - 436 77 01'
        ),
        Doctor(
            name: 'Iniara Rodriguez',
            speciality: 'Cirugía',
            consultory: 'Piso 2 - consultorio 1',
            phone_number: '(987) - 282 34 01'
        ),
      ]
  );

  test('Should get a directory', () async {
    when(dashboardRepository.getDirectory()).
      thenAnswer((_) async => const Right(directory));

    final result = await getDirectory.call(null);
    expect(result, const Right(directory));

    verify(dashboardRepository.getDirectory());
    verifyNoMoreInteractions(dashboardRepository);
  });
}