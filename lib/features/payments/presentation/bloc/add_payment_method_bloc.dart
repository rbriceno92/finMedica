import 'dart:async';

import 'package:app/features/payments/data/models/create_payment_method_request.dart';
import 'package:app/features/payments/domain/use_cases/create_payment_method_use_case.dart';
import 'package:app/features/payments/presentation/bloc/add_payment_method_events.dart';
import 'package:app/features/payments/presentation/bloc/add_payment_method_state.dart';
import 'package:app/util/constants/constants.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/models/message_model.dart';
import 'package:app/util/user_preferences_save.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class AddPaymentMethodBloc
    extends Bloc<AddPaymentMethodEvent, AddPaymentMethodState> {
  CreatePaymentMethodUseCase createPaymentMethodUseCase;

  UserPreferenceDao dao;

  AddPaymentMethodBloc(
      {required this.createPaymentMethodUseCase, required this.dao})
      : super(const AddPaymentMethodState()) {
    on<DisposeLoading>(_onDisposeLoading);
    on<LoadUser>(_onLoadUser);
    on<CreatePaymentMethod>(onCreatePaymentMethod);
  }

  FutureOr<void> _onDisposeLoading(
          DisposeLoading event, Emitter<AddPaymentMethodState> emit) async =>
      emit(state.copyWith(
          loading: LoadingState.dispose, errorMessage: '', successMessage: ''));

  FutureOr<void> _onLoadUser(
      LoadUser event, Emitter<AddPaymentMethodState> emit) async {
    final userResponse = await dao.getUser();
    var user = userResponse.fold((error) => null, (modelUser) => modelUser);
    emit(state.copyWith(user: user));
  }

  FutureOr<void> onCreatePaymentMethod(
      CreatePaymentMethod event, Emitter<AddPaymentMethodState> emit) async {
    emit(state.copyWith(loading: LoadingState.show));

    try {
      final paymentMethod = await Stripe.instance.createPaymentMethod(
          params: const PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(),
      ));

      var response = await createPaymentMethodUseCase.call(
          CreatePaymentMethodRequest(
              stripeCustomerId: state.user.stripeCustomerId ?? '',
              paymentMethodId: paymentMethod.id));
      response.fold((error) {
        emit(state.copyWith(
            loading: LoadingState.close,
            successMessage: '',
            errorMessage: getErrorMessage(error)));
      }, (response) {
        emit(state.copyWith(
            loading: LoadingState.close,
            successMessage: response.message,
            errorMessage: ''));
      });
    } catch (error) {
      if (error is StripeException) {
        emit(state.copyWith(
            loading: LoadingState.close,
            successMessage: '',
            errorMessage: error.error.localizedMessage));
      } else {
        emit(state.copyWith(
            loading: LoadingState.close,
            successMessage: '',
            errorMessage: ERROR_MESSAGE));
      }
    }
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
