import 'package:app/util/enums.dart';
import 'package:app/util/models/model_user.dart';
import 'package:equatable/equatable.dart';

class AddPaymentMethodState extends Equatable {
  final LoadingState loading;
  final String errorMessage;
  final String successMessage;
  final ModelUser user;

  const AddPaymentMethodState(
      {this.errorMessage = '',
      this.successMessage = '',
      this.loading = LoadingState.dispose,
      this.user = const ModelUser()});

  AddPaymentMethodState copyWith(
          {LoadingState? loading,
          String? errorMessage,
          String? successMessage,
          ModelUser? user}) =>
      AddPaymentMethodState(
          errorMessage: errorMessage ?? this.errorMessage,
          successMessage: successMessage ?? this.successMessage,
          loading: loading ?? this.loading,
          user: user ?? this.user);

  @override
  List<Object?> get props => [loading, user, errorMessage, successMessage];
}
