import 'package:equatable/equatable.dart';

abstract class MyCouponsCodeEvent extends Equatable {
  const MyCouponsCodeEvent();
}

class CodeChange extends MyCouponsCodeEvent {
  final String code;
  const CodeChange({required this.code});

  @override
  List<Object?> get props => [code];
}

class DisposeLoading extends MyCouponsCodeEvent {
  @override
  List<Object?> get props => [];
}

class SendCode extends MyCouponsCodeEvent {
  const SendCode();

  @override
  List<Object?> get props => [];
}
