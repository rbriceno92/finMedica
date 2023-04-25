import 'package:equatable/equatable.dart';

abstract class ContactUsEvent extends Equatable {
  const ContactUsEvent();
}

class SubjectChange extends ContactUsEvent {
  final String text;

  const SubjectChange({required this.text});

  @override
  List<Object?> get props => [text];
}

class MessageChange extends ContactUsEvent {
  final String text;

  const MessageChange({required this.text});

  @override
  List<Object?> get props => [text];
}

class DisposeLoading extends ContactUsEvent {
  @override
  List<Object?> get props => [];
}

class SendData extends ContactUsEvent {
  const SendData();

  @override
  List<Object?> get props => [];
}

class ClearMesssage extends ContactUsEvent {
  @override
  List<Object?> get props => [];
}
