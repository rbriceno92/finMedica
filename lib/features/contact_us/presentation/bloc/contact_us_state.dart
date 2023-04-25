import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';

class ContactUsState extends Equatable {
  final String subject;
  final String message;
  final bool enableContinue;
  final LoadingState loading;
  final String messageError;
  final String messageSucces;

  const ContactUsState(
      {this.subject = '',
      this.message = '',
      this.enableContinue = false,
      this.loading = LoadingState.dispose,
      this.messageError = '',
      this.messageSucces = ''});

  ContactUsState copyWith({
    String? subject,
    String? message,
    bool? subjectHasError,
    bool? messageHasError,
    bool? enableContinue,
    LoadingState? loading,
    String? messageError,
    String? messageSucces,
  }) {
    return ContactUsState(
      subject: subject ?? this.subject,
      message: message ?? this.message,
      enableContinue: enableContinue ?? this.enableContinue,
      loading: loading ?? this.loading,
      messageError: messageError ?? this.messageError,
      messageSucces: messageSucces ?? this.messageSucces,
    );
  }

  @override
  List<Object?> get props => [
        subject,
        message,
        loading,
        enableContinue,
        messageError,
        messageSucces,
      ];
}
