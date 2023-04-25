import 'package:app/features/directory/data/models/book_appointment_params.dart';
import 'package:app/features/directory/data/models/book_appointment_response.dart';
import 'package:app/features/directory/domain/repositories/directory_repository.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/use_case.dart';
import 'package:dartz/dartz.dart';

class BookAppointmentUseCase
    extends UseCase<BookAppointmentResponse, BookAppointmentParams> {
  final DirectoryRepository repository;

  BookAppointmentUseCase({required this.repository});

  @override
  Future<Either<ErrorGeneral, BookAppointmentResponse>> call(
      BookAppointmentParams param) async {
    return await repository.bookAppointment(param);
  }
}
