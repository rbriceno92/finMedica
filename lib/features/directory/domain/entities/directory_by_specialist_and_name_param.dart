import 'package:equatable/equatable.dart';

class DirectoryBySpecialistAndNameParam extends Equatable {
  final int? specialist;
  final String? name;
  final int hospital;

  const DirectoryBySpecialistAndNameParam(
      {required this.specialist, required this.name, required this.hospital});

  @override
  List<Object?> get props => [specialist, name, hospital];
}
