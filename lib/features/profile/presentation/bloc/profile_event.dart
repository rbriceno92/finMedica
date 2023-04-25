import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class OnGetUserInfo extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class OnEditPhone extends ProfileEvent {
  final String phone;

  const OnEditPhone({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class OnSavePhone extends ProfileEvent {
  final String phone;

  const OnSavePhone({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class OnEditEmail extends ProfileEvent {
  final String email;

  const OnEditEmail({required this.email});

  @override
  List<Object?> get props => [email];
}

class OnSaveEmail extends ProfileEvent {
  final String email;

  const OnSaveEmail({required this.email});

  @override
  List<Object?> get props => [email];
}

class OnShowCurpInfo extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class CleanMessage extends ProfileEvent {
  @override
  List<Object?> get props => [];
}
