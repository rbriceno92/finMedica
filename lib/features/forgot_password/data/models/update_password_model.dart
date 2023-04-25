import 'package:equatable/equatable.dart';

class UpdatePasswordModel extends Equatable {
  final String token;
  final String password;

  const UpdatePasswordModel({required this.token, required this.password});

  @override
  List<Object?> get props => [token, password];
}
