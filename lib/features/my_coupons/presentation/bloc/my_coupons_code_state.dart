import 'package:app/util/enums.dart';
import 'package:equatable/equatable.dart';

class MyCouponsCodeState extends Equatable {
  final String code;
  final bool enableButtom;
  final bool codeError;
  final LoadingState loading;
  final String messageError;
  final String messageSuccess;

  const MyCouponsCodeState(
      {this.code = '',
      this.messageSuccess = '',
      this.messageError = '',
      this.enableButtom = false,
      this.codeError = false,
      this.loading = LoadingState.dispose});

  MyCouponsCodeState copyWith(
          {String? code,
          bool? enableButtom,
          bool? codeError,
          String? messageError,
          String? messageSuccess,
          LoadingState? loading}) =>
      MyCouponsCodeState(
          messageError: messageError ?? this.messageError,
          code: code ?? this.code,
          messageSuccess: messageSuccess ?? this.messageSuccess,
          enableButtom: enableButtom ?? this.enableButtom,
          codeError: codeError ?? this.codeError,
          loading: loading ?? this.loading);

  @override
  List<Object?> get props =>
      [code, enableButtom, codeError, loading, messageError, messageSuccess];
}
