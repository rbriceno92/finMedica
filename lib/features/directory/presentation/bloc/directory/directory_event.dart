import 'package:equatable/equatable.dart';

abstract class DirectoryEvent extends Equatable {
  const DirectoryEvent();
}

class LoadDirectory extends DirectoryEvent {
  const LoadDirectory();

  @override
  List<Object?> get props => [];
}

class LoadDirectoryBySpecialistAndName extends DirectoryEvent {
  final int? specialist;
  final String? name;

  const LoadDirectoryBySpecialistAndName(
      {required this.specialist, required this.name});

  @override
  List<Object?> get props => [specialist, name];
}

class LoadUser extends DirectoryEvent {
  @override
  List<Object?> get props => [];
}

class LoadSpecialities extends DirectoryEvent {
  @override
  List<Object?> get props => [];
}

class CleanMessage extends DirectoryEvent {
  @override
  List<Object?> get props => [];
}
