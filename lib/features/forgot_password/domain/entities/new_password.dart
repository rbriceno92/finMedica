import 'package:equatable/equatable.dart';

class NewPassword extends Equatable {
  final String newPassword;
  final String repeatPassword;

  const NewPassword({required this.newPassword, required this.repeatPassword});

  @override
  List<Object?> get props => [newPassword, repeatPassword];
}
