import 'package:app/features/directory/domain/entities/doctor.dart';
import 'package:equatable/equatable.dart';

class Directory extends Equatable {
  final List<Doctor> doctors;

  const Directory({required this.doctors});

  @override
  List<Object?> get props => [doctors];
}
