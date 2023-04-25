import 'package:equatable/equatable.dart';

class Patient extends Equatable {
  final String name;

  const Patient({required this.name});

  @override
  List<Object?> get props => [name];
}
