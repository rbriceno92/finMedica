import 'dart:async';

import 'package:app/features/payments/data/models/delete_payment_method_request.dart';
import 'package:app/features/payments/domain/use_cases/delete_payment_method_use_case.dart';
import 'package:app/features/payments/domain/use_cases/get_payment_methods_use_case.dart';
import 'package:app/features/payments/presentation/bloc/payment_method_events.dart';
import 'package:app/features/payments/presentation/bloc/payment_method_state.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/models/message_model.dart';
import 'package:app/util/user_preferences_save.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodsBloc
    extends Bloc<PaymentMethodsEvent, PaymentMethodsState> {
  GetPaymentMethodsUseCase getPaymentMethodsUseCase;
  DeletePaymentMethodUseCase deletePaymentMethodUseCase;
  UserPreferenceDao dao;

  PaymentMethodsBloc(
      {required this.getPaymentMethodsUseCase,
      required this.deletePaymentMethodUseCase,
      required this.dao})
      : super(const PaymentMethodsState()) {
    on<DisposeLoading>(_onDisposeLoading);
    on<LoadUser>(_onLoadUser);
    on<FetchData>(_onFetchData);
    on<RemovePaymentMethod>(_onRemovePaymentMethod);
  }

  FutureOr<void> _onDisposeLoading(
          DisposeLoading event, Emitter<PaymentMethodsState> emit) async =>
      emit(state.copyWith(
          loading: LoadingState.dispose, errorMessage: '', successMessage: ''));

  FutureOr<void> _onLoadUser(
      LoadUser event, Emitter<PaymentMethodsState> emit) async {
    final userResponse = await dao.getUser();
    var user = userResponse.fold((error) => null, (modelUser) => modelUser);
    emit(state.copyWith(user: user));
  }

  FutureOr<void> _onFetchData(
      FetchData event, Emitter<PaymentMethodsState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));

    var response =
        await getPaymentMethodsUseCase.call(state.user.stripeCustomerId ?? '');
    response.fold(
        (error) => emit(state.copyWith(
            loading: LoadingState.close,
            paymentMethods: [],
            errorMessage: getErrorMessage(error))), (response) {
      emit(state.copyWith(
          loading: LoadingState.close,
          paymentMethods:
              response.userPaymentMethods.map((e) => e.toEntity()).toList(),
          errorMessage: ''));
    });
  }

  FutureOr<void> _onRemovePaymentMethod(
      RemovePaymentMethod event, Emitter<PaymentMethodsState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));

    var response = await deletePaymentMethodUseCase.call(
        DeletePaymentMethodRequest(
            stripeCustomerId: state.user.stripeCustomerId ?? '',
            paymentMethodId: event.paymentMethodId));
    response.fold(
        (error) => emit(state.copyWith(
            loading: LoadingState.close,
            errorMessage: getErrorMessage(error))), (response) {
      emit(state.copyWith(
          loading: LoadingState.close,
          successMessage: response.message,
          paymentMethods: state.paymentMethods
              .where((element) => element.id != event.paymentMethodId)
              .toList(),
          errorMessage: ''));
    });
  }

  String getErrorMessage(ErrorGeneral error) {
    if (error is ServerFailure) {
      return error.modelServer.isSimple()
          ? error.modelServer.message as String
          : (error.modelServer.message as List<MessageModel>)
              .map((e) => e.message)
              .join(', ');
    }
    if (error is ErrorMessage) {
      return error.message;
    }
    return ERROR_MESSAGE;
  }
}
