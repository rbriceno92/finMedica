import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final String speciality;
  final String name;

  const Doctor({required this.speciality, required this.name});

  @override
  List<Object?> get props => [speciality, name];
}
