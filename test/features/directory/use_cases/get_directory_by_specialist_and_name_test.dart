
import 'package:app/features/directory/domain/entities/directory.dart';
import 'package:app/features/directory/domain/entities/directory_by_specialist_and_name_param.dart';
import 'package:app/features/directory/domain/entities/doctor.dart';
import 'package:app/features/directory/domain/repositories/directory_repository.dart';
import 'package:app/features/directory/domain/use_cases/get_directory_by_specialist_and_name.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_directory_test.mocks.dart';

@GenerateMocks([DirectoryRepository])
void main(){
  late GetDirectoryBySpecialistAndName getDirectory;
  late MockDirectoryRepository dashboardRepository;

  setUp(() {
    dashboardRepository = MockDirectoryRepository();
    getDirectory = GetDirectoryBySpecialistAndName(repository: dashboardRepository);
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
            name: 'Rodolfo Ramirez',
            speciality: 'Cardiología',
            consultory: 'Piso 5 - consultorio 3',
            phone_number: '(000) - 000 00 01'
        ),
        Doctor(
            name: 'Rodolfo nuñez',
            speciality: 'Cardiología',
            consultory: 'Piso 3 - consultorio 1',
            phone_number:'(000) - 344 03 01'
        )
      ]
  );

  var specialistParam = 'cardiologia';
  var doctorNameParam = 'Rodolfo';

  test('Should get a directory filtered by specialist and name', () async {
    when(dashboardRepository.getDirectoryBySpecialistAndName(specialistParam, doctorNameParam)).
    thenAnswer((_) async => const Right(directory));

    final result = await getDirectory.call(
        DirectoryBySpecialistAndNameParam(
            specialist: specialistParam,
            name: doctorNameParam
        )
    );
    expect(result, const Right(directory));

    verify(dashboardRepository.getDirectoryBySpecialistAndName(specialistParam, doctorNameParam));
    verifyNoMoreInteractions(dashboardRepository);
  });
}