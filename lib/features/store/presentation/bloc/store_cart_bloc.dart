import 'package:app/features/payments/data/models/create_payment_request.dart';
import 'package:app/features/store/domain/use_case/payment_create_use_case.dart';
import 'package:app/features/store/presentation/bloc/store_cart_events.dart';
import 'package:app/features/store/presentation/bloc/store_cart_state.dart';
import 'package:app/util/enums.dart';
import 'package:app/util/failure.dart';
import 'package:app/util/models/message_model.dart';
import 'package:app/util/user_preferences_save.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreCartBloc extends Bloc<StoreCartEvent, StoreCartState> {
  CreatePaymentIntentUseCase createPaymentIntentUseCase;
  UserPreferenceDao userDao;

  StoreCartBloc(
      {required this.createPaymentIntentUseCase, required this.userDao})
      : super(const StoreCartState()) {
    on<DisposeLoading>(_onDisposeLoading);
    on<SetCartItem>(_onSetCartItem);
    on<PayCartItem>(_onPayCartItem);
  }

  void _onDisposeLoading(
          DisposeLoading event, Emitter<StoreCartState> emit) async =>
      emit(state.copyWith(loading: LoadingState.dispose));

  void _onSetCartItem(SetCartItem event, Emitter<StoreCartState> emit) async =>
      emit(StoreCartState(item: event.item, loading: state.loading));

  void _onPayCartItem(PayCartItem event, Emitter<StoreCartState> emit) async {
    emit(StoreCartState(item: state.item, loading: LoadingState.show));

    var userDaoResult = await userDao.getUser();
    var user = userDaoResult.fold((error) => null, (user) => user);

    if (user == null) {
      event.onError('Error al cargar los datos del usuario');
      emit(state.copyWith(loading: LoadingState.close));
      return;
    }

    var result = await createPaymentIntentUseCase.call(CreatePaymentRequest(
        email: user.email ?? '', productId: state.item?.id ?? ''));

    List<String> status = result.fold(
      (l) {
        if (l is ServerFailure) {
          return [
            'Error',
            l.modelServer.isSimple()
                ? (l.modelServer.message as String)
                : (l.modelServer.message as List<MessageModel>?)!
                    .map((e) => e.message)
                    .join(', ')
          ];
        } else {
          return ['Error', (l as ErrorMessage).message];
        }
      },
      (r) {
        return ['', r.clientSecret, r.ephemeralKey];
      },
    );

    if (status.first.isNotEmpty) {
      event.onError(status.last);
      emit(state.copyWith(loading: LoadingState.close));
      return;
    }

    emit(StoreCartState(
        loading: LoadingState.close,
        item: state.item,
        customerId: user.stripeCustomerId,
        paymentIntentClientSecret: status[1],
        customerEphemeralKeySecret: status[2]));
  }
}
